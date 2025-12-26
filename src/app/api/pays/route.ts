import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// GET /api/pays - Lấy danh sách thanh toán
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

        const [pays, total] = await Promise.all([
            prisma.pay.findMany({
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
            prisma.pay.count({ where }),
        ])

        return NextResponse.json({
            data: pays,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        })
    } catch (error) {
        console.error('Get pays error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}

// POST /api/pays - Tạo thanh toán mới
export async function POST(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const body = await request.json()
        const { proId, warehouseId, total, price, reportDate, note, brandId } = body

        if (!total || !price) {
            return NextResponse.json(
                { error: 'Số lượng và đơn giá là bắt buộc' },
                { status: 400 }
            )
        }

        const pay = await prisma.pay.create({
            data: {
                proId: proId ? parseInt(proId) : null,
                warehouseId: warehouseId ? parseInt(warehouseId) : (user.warehouseId || 1),
                total: parseInt(total),
                price: parseInt(price),
                reportDate: reportDate ? new Date(reportDate) : new Date(),
                note,
                brandId: brandId ? parseInt(brandId) : null,
                campainId: user.campainId,
                createdBy: user.userId,
            },
            include: {
                product: { include: { brand: true } },
                warehouse: true,
            },
        })

        return NextResponse.json({ data: pay }, { status: 201 })
    } catch (error) {
        console.error('Create pay error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
