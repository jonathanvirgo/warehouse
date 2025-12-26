import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// GET /api/exports - Lấy danh sách phiếu xuất
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

        const [exports, total] = await Promise.all([
            prisma.export.findMany({
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
            prisma.export.count({ where }),
        ])

        // Tính tổng doanh thu và lợi nhuận
        const stats = await prisma.export.aggregate({
            where,
            _sum: {
                income: true,
            },
        })

        return NextResponse.json({
            data: exports,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
            stats: {
                totalIncome: stats._sum.income || 0,
            },
        })
    } catch (error) {
        console.error('Get exports error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}

// POST /api/exports - Tạo phiếu xuất mới
export async function POST(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const body = await request.json()
        const {
            proId,
            warehouseId,
            total,
            priceImport,
            priceExport,
            reportDate,
            note,
            discount,
            ship,
            typeDiscount,
            brandId,
        } = body

        if (!proId || !total || !priceExport) {
            return NextResponse.json(
                { error: 'Sản phẩm, số lượng và giá bán là bắt buộc' },
                { status: 400 }
            )
        }

        // Tính lợi nhuận
        const income = (parseInt(priceExport) - parseInt(priceImport || '0')) * parseInt(total) - (parseInt(discount || '0')) + (parseInt(ship || '0'))

        const exportRecord = await prisma.export.create({
            data: {
                proId: parseInt(proId),
                warehouseId: warehouseId ? parseInt(warehouseId) : (user.warehouseId || 1),
                total: parseInt(total),
                priceImport: parseInt(priceImport || '0'),
                priceExport: parseInt(priceExport),
                income,
                discount: discount ? parseInt(discount) : null,
                ship: ship ? parseInt(ship) : null,
                typeDiscount: typeDiscount ? parseInt(typeDiscount) : null,
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

        return NextResponse.json({ data: exportRecord }, { status: 201 })
    } catch (error) {
        console.error('Create export error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
