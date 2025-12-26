import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

// GET /api/warehouses/[id]
export async function GET(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        const warehouse = await prisma.warehouse.findUnique({
            where: { id: parseInt(id) },
        })

        if (!warehouse) {
            return NextResponse.json({ error: 'Warehouse not found' }, { status: 404 })
        }

        return NextResponse.json(warehouse)
    } catch (error) {
        console.error('Error fetching warehouse:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}

// PUT /api/warehouses/[id]
export async function PUT(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        const body = await request.json()
        const { name } = body

        const warehouse = await prisma.warehouse.update({
            where: { id: parseInt(id) },
            data: { name },
        })

        return NextResponse.json(warehouse)
    } catch (error) {
        console.error('Error updating warehouse:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}

// DELETE /api/warehouses/[id]
export async function DELETE(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        await prisma.warehouse.delete({
            where: { id: parseInt(id) },
        })

        return NextResponse.json({ message: 'Warehouse deleted' })
    } catch (error) {
        console.error('Error deleting warehouse:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}
