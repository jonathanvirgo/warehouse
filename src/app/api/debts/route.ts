import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// GET /api/debts - Lấy danh sách công nợ
export async function GET(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const { searchParams } = new URL(request.url)
        const warehouseId = searchParams.get('warehouseId')
        const page = parseInt(searchParams.get('page') || '1')
        const limit = parseInt(searchParams.get('limit') || '20')
        const skip = (page - 1) * limit

        const where = {
            ...(user.campainId && { campainId: user.campainId }),
            ...(warehouseId && { warehouseId: parseInt(warehouseId) }),
        }

        const [debts, total, stats] = await Promise.all([
            prisma.debt.findMany({
                where,
                include: {
                    product: { include: { brand: true } },
                    warehouse: true,
                    user: { select: { id: true, name: true } },
                },
                orderBy: { reportDate: 'desc' },
                skip,
                take: limit,
            }),
            prisma.debt.count({ where }),
            prisma.debt.aggregate({
                where,
                _sum: {
                    total: true,
                    price: true,
                },
            }),
        ])

        // Tính tổng tiền công nợ
        const totalDebt = debts.reduce((sum, d) => sum + ((d.total || 0) * (d.price || 0)), 0)

        return NextResponse.json({
            data: debts,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
            stats: {
                totalDebt,
                totalQuantity: stats._sum.total || 0,
            },
        })
    } catch (error) {
        console.error('Get debts error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}

// POST /api/debts - Tạo công nợ mới
export async function POST(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const body = await request.json()
        const { proId, warehouseId, total, price, reportDate, brandId } = body

        if (!proId || !total || !price) {
            return NextResponse.json(
                { error: 'Sản phẩm, số lượng và đơn giá là bắt buộc' },
                { status: 400 }
            )
        }

        const debt = await prisma.debt.create({
            data: {
                proId: parseInt(proId),
                warehouseId: warehouseId ? parseInt(warehouseId) : null,
                total: parseInt(total),
                price: parseInt(price),
                reportDate: reportDate ? new Date(reportDate) : new Date(),
                brandId: brandId ? parseInt(brandId) : null,
                campainId: user.campainId,
                createdBy: user.userId,
            },
            include: {
                product: { include: { brand: true } },
                warehouse: true,
            },
        })

        return NextResponse.json({ data: debt }, { status: 201 })
    } catch (error) {
        console.error('Create debt error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
