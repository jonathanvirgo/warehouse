import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// GET /api/imports - Lấy danh sách phiếu nhập
export async function GET(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const { searchParams } = new URL(request.url)
        const warehouseId = searchParams.get('warehouseId')
        const productId = searchParams.get('productId')
        const startDate = searchParams.get('startDate')
        const endDate = searchParams.get('endDate')
        const page = parseInt(searchParams.get('page') || '1')
        const limit = parseInt(searchParams.get('limit') || '20')
        const skip = (page - 1) * limit

        const where = {
            ...(user.campainId && { campainId: user.campainId }),
            ...(user.warehouseId && { warehouseId: user.warehouseId }),
            ...(warehouseId && { warehouseId: parseInt(warehouseId) }),
            ...(productId && { proId: parseInt(productId) }),
            ...(startDate && endDate && {
                reportDate: {
                    gte: new Date(startDate),
                    lte: new Date(endDate),
                },
            }),
        }

        const [imports, total] = await Promise.all([
            prisma.import.findMany({
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
            prisma.import.count({ where }),
        ])

        return NextResponse.json({
            data: imports,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        })
    } catch (error) {
        console.error('Get imports error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}

// POST /api/imports - Tạo phiếu nhập mới
export async function POST(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const body = await request.json()
        const { proId, warehouseId, total, price, reportDate, note, brandId } = body

        if (!proId || !total || !price) {
            return NextResponse.json(
                { error: 'Sản phẩm, số lượng và đơn giá là bắt buộc' },
                { status: 400 }
            )
        }

        const importRecord = await prisma.import.create({
            data: {
                proId: parseInt(proId),
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

        return NextResponse.json({ data: importRecord }, { status: 201 })
    } catch (error) {
        console.error('Create import error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
