import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

// GET /api/brands - List brands with pagination, search, sort
export async function GET(request: NextRequest) {
    try {
        const searchParams = request.nextUrl.searchParams
        const page = parseInt(searchParams.get('page') || '1')
        const limit = parseInt(searchParams.get('limit') || '100')
        const search = searchParams.get('search') || ''
        const sortBy = searchParams.get('sortBy') || 'id'
        const sortOrder = searchParams.get('sortOrder') || 'asc'

        const where = search
            ? {
                name: { contains: search, mode: 'insensitive' as const },
            }
            : {}

        const orderBy = { [sortBy]: sortOrder }

        const [data, total] = await Promise.all([
            prisma.brand.findMany({
                where,
                orderBy,
                skip: (page - 1) * limit,
                take: limit,
            }),
            prisma.brand.count({ where }),
        ])

        return NextResponse.json({
            data,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        })
    } catch (error) {
        console.error('Error fetching brands:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}

// POST /api/brands - Create brand
export async function POST(request: NextRequest) {
    try {
        const body = await request.json()
        const { name } = body

        if (!name) {
            return NextResponse.json({ error: 'Name is required' }, { status: 400 })
        }

        const brand = await prisma.brand.create({
            data: { name },
        })

        return NextResponse.json(brand, { status: 201 })
    } catch (error) {
        console.error('Error creating brand:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}
