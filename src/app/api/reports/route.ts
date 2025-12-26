import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// GET /api/reports - Lấy báo cáo theo tháng
export async function GET(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const searchParams = request.nextUrl.searchParams
        const year = parseInt(searchParams.get('year') || new Date().getFullYear().toString())
        const type = searchParams.get('type') || 'revenue' // revenue, profit, inventory

        const where = user.campainId ? { campainId: user.campainId } : {}

        // Lấy dữ liệu 12 tháng
        const monthlyData: Array<{ month: string; revenue: number; profit: number; cost: number }> = []

        for (let month = 1; month <= 12; month++) {
            const startDate = new Date(year, month - 1, 1)
            const endDate = new Date(year, month, 0) // Last day of month

            // Tổng xuất kho (doanh thu)
            const exports = await prisma.export.aggregate({
                where: {
                    ...where,
                    reportDate: { gte: startDate, lte: endDate },
                },
                _sum: {
                    income: true,
                    priceExport: true,
                    priceImport: true,
                    total: true,
                },
            })

            // Tổng nhập kho (chi phí)
            const imports = await prisma.import.aggregate({
                where: {
                    ...where,
                    reportDate: { gte: startDate, lte: endDate },
                },
                _sum: {
                    price: true,
                    total: true,
                },
            })

            const revenue = exports._sum.income || 0
            const cost = (imports._sum.price || 0) * (imports._sum.total || 0)
            const profit = revenue - cost

            monthlyData.push({
                month: `T${month}`,
                revenue,
                profit: profit > 0 ? profit : 0,
                cost,
            })
        }

        // Lấy tồn kho theo kho
        let inventoryData: Array<{ warehouse: string; quantity: number }> = []
        if (type === 'inventory') {
            const warehouses = await prisma.warehouse.findMany({
                where: user.campainId ? { campainId: user.campainId } : {},
            })

            for (const wh of warehouses) {
                const imports = await prisma.import.aggregate({
                    where: { warehouseId: wh.id, ...where },
                    _sum: { total: true },
                })
                const exports = await prisma.export.aggregate({
                    where: { warehouseId: wh.id, ...where },
                    _sum: { total: true },
                })
                const quantity = (imports._sum.total || 0) - (exports._sum.total || 0)
                inventoryData.push({ warehouse: wh.name, quantity: Math.max(0, quantity) })
            }
        }

        return NextResponse.json({
            monthlyData,
            inventoryData,
            year,
        })
    } catch (error) {
        console.error('Get reports error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
