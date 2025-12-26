import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// GET /api/products/[id]
export async function GET(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const { id } = await params
        const product = await prisma.product.findUnique({
            where: { id: parseInt(id) },
            include: { brand: true },
        })

        if (!product) {
            return NextResponse.json(
                { error: 'Sản phẩm không tồn tại' },
                { status: 404 }
            )
        }

        return NextResponse.json({ data: product })
    } catch (error) {
        console.error('Get product error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}

// PUT /api/products/[id]
export async function PUT(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const { id } = await params
        const body = await request.json()
        const { name, brandId, image } = body

        const product = await prisma.product.update({
            where: { id: parseInt(id) },
            data: {
                name,
                brandId: brandId ? parseInt(brandId) : null,
                image,
            },
            include: { brand: true },
        })

        return NextResponse.json({ data: product })
    } catch (error) {
        console.error('Update product error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}

// DELETE /api/products/[id]
export async function DELETE(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const user = await getCurrentUser()
        if (!user) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const { id } = await params
        await prisma.product.delete({
            where: { id: parseInt(id) },
        })

        return NextResponse.json({ message: 'Xóa thành công' })
    } catch (error) {
        console.error('Delete product error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
