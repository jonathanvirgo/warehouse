import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// GET /api/products - Lấy danh sách sản phẩm
export async function GET(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const { searchParams } = new URL(request.url)
        const search = searchParams.get('search') || ''
        const brandId = searchParams.get('brandId')
        const page = parseInt(searchParams.get('page') || '1')
        const limit = parseInt(searchParams.get('limit') || '10')
        const skip = (page - 1) * limit

        const where = {
            ...(user.campainId && { campainId: user.campainId }),
            ...(search && {
                OR: [
                    { name: { contains: search, mode: 'insensitive' as const } },
                ],
            }),
            ...(brandId && { brandId: parseInt(brandId) }),
        }

        const [products, total] = await Promise.all([
            prisma.product.findMany({
                where,
                include: {
                    brand: true,
                },
                orderBy: { createdAt: 'desc' },
                skip,
                take: limit,
            }),
            prisma.product.count({ where }),
        ])

        return NextResponse.json({
            data: products,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        })
    } catch (error) {
        console.error('Get products error:', error)
        return NextResponse.json(
            { error: 'Có lỗi xảy ra' },
            { status: 500 }
        )
    }
}

// POST /api/products - Tạo sản phẩm mới
export async function POST(request: NextRequest) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const body = await request.json()
        const { name, brandId, image } = body

        if (!name) {
            return NextResponse.json(
                { error: 'Tên sản phẩm là bắt buộc' },
                { status: 400 }
            )
        }

        const product = await prisma.product.create({
            data: {
                name,
                brandId: brandId ? parseInt(brandId) : null,
                campainId: user.campainId || 1,
                image,
            },
            include: {
                brand: true,
            },
        })

        return NextResponse.json({ data: product }, { status: 201 })
    } catch (error) {
        console.error('Create product error:', error)
        return NextResponse.json(
            { error: 'Có lỗi xảy ra' },
            { status: 500 }
        )
    }
}
