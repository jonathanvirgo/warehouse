import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

// GET /api/roles - List all roles
export async function GET() {
    try {
        const roles = await prisma.role.findMany({
            orderBy: { id: 'asc' },
        })

        return NextResponse.json({ data: roles })
    } catch (error) {
        console.error('Error fetching roles:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}
