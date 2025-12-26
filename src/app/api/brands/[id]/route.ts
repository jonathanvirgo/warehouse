import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

// GET /api/brands/[id]
export async function GET(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        const brand = await prisma.brand.findUnique({
            where: { id: parseInt(id) },
        })

        if (!brand) {
            return NextResponse.json({ error: 'Brand not found' }, { status: 404 })
        }

        return NextResponse.json(brand)
    } catch (error) {
        console.error('Error fetching brand:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}

// PUT /api/brands/[id]
export async function PUT(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        const body = await request.json()
        const { name } = body

        const brand = await prisma.brand.update({
            where: { id: parseInt(id) },
            data: { name },
        })

        return NextResponse.json(brand)
    } catch (error) {
        console.error('Error updating brand:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}

// DELETE /api/brands/[id]
export async function DELETE(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        await prisma.brand.delete({
            where: { id: parseInt(id) },
        })

        return NextResponse.json({ message: 'Brand deleted' })
    } catch (error) {
        console.error('Error deleting brand:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}
