import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

// GET /api/campaigns/[id] - Get single campaign
export async function GET(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        const campaign = await prisma.campain.findUnique({
            where: { id: parseInt(id) },
        })

        if (!campaign) {
            return NextResponse.json({ error: 'Campaign not found' }, { status: 404 })
        }

        return NextResponse.json(campaign)
    } catch (error) {
        console.error('Error fetching campaign:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}

// PUT /api/campaigns/[id] - Update campaign
export async function PUT(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        const body = await request.json()
        const { name } = body

        const campaign = await prisma.campain.update({
            where: { id: parseInt(id) },
            data: { name },
        })

        return NextResponse.json(campaign)
    } catch (error) {
        console.error('Error updating campaign:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}

// DELETE /api/campaigns/[id] - Delete campaign
export async function DELETE(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id } = await params
        await prisma.campain.delete({
            where: { id: parseInt(id) },
        })

        return NextResponse.json({ message: 'Campaign deleted' })
    } catch (error) {
        console.error('Error deleting campaign:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}
