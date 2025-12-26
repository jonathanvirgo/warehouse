import { NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// GET /api/dashboard - Lấy thống kê dashboard
export async function GET() {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const where = {
            ...(user.campainId && { campainId: user.campainId }),
            ...(user.warehouseId && { warehouseId: user.warehouseId }),
        }

        // Lấy ngày đầu tháng
        const now = new Date()
        const firstDayOfMonth = new Date(now.getFullYear(), now.getMonth(), 1)

        // Thống kê xuất kho tháng này
        const exportsThisMonth = await prisma.export.aggregate({
            where: {
                ...where,
                reportDate: { gte: firstDayOfMonth },
            },
            _sum: {
                income: true,
            },
            _count: true,
        })

        // Thống kê nhập kho tháng này
        const importsThisMonth = await prisma.import.aggregate({
            where: {
                ...where,
                reportDate: { gte: firstDayOfMonth },
            },
            _count: true,
        })

        // Tổng công nợ
        const totalDebt = await prisma.debt.aggregate({
            where,
            _sum: {
                total: true,
                price: true,
            },
        })

        // Đếm sản phẩm
        const productCount = await prisma.product.count({
            where: user.campainId ? { campainId: user.campainId } : {},
        })

        // Lấy hoạt động gần đây
        const [recentImports, recentExports] = await Promise.all([
            prisma.import.findMany({
                where,
                include: {
                    product: true,
                    user: { select: { name: true } },
                },
                orderBy: { createdAt: 'desc' },
                take: 5,
            }),
            prisma.export.findMany({
                where,
                include: {
                    product: true,
                    user: { select: { name: true } },
                },
                orderBy: { createdAt: 'desc' },
                take: 5,
            }),
        ])

        return NextResponse.json({
            stats: {
                totalRevenue: exportsThisMonth._sum.income || 0,
                totalProfit: exportsThisMonth._sum.income || 0, // Simplified
                totalDebt: (totalDebt._sum.total || 0) * (totalDebt._sum.price || 0),
                lowStockCount: 0, // TODO: Implement low stock calculation
                productCount,
                exportCount: exportsThisMonth._count,
                importCount: importsThisMonth._count,
            },
            recentImports,
            recentExports,
        })
    } catch (error) {
        console.error('Get dashboard error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
