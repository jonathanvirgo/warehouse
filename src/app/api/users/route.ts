import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import bcrypt from 'bcryptjs'

// GET /api/users - List users with pagination, search, sort
export async function GET(request: NextRequest) {
    try {
        const searchParams = request.nextUrl.searchParams
        const page = parseInt(searchParams.get('page') || '1')
        const limit = parseInt(searchParams.get('limit') || '10')
        const search = searchParams.get('search') || ''
        const sortBy = searchParams.get('sortBy') || 'id'
        const sortOrder = searchParams.get('sortOrder') || 'desc'

        const where = search
            ? {
                OR: [
                    { name: { contains: search, mode: 'insensitive' as const } },
                    { email: { contains: search, mode: 'insensitive' as const } },
                ],
            }
            : {}

        const orderBy = { [sortBy]: sortOrder }

        const [data, total] = await Promise.all([
            prisma.user.findMany({
                where,
                orderBy,
                skip: (page - 1) * limit,
                take: limit,
                select: {
                    id: true,
                    name: true,
                    email: true,
                    avatar: true,
                    roleId: true,
                    warehouseId: true,
                    campainId: true,
                    createdAt: true,
                    updatedAt: true,
                    warehouse: { select: { id: true, name: true } },
                    campain: { select: { id: true, name: true } },
                },
            }),
            prisma.user.count({ where }),
        ])

        return NextResponse.json({
            data,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        })
    } catch (error) {
        console.error('Error fetching users:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}

// POST /api/users - Create user
export async function POST(request: NextRequest) {
    try {
        const body = await request.json()
        const { name, email, password, roleId, warehouseId, campainId } = body

        if (!name || !email || !password) {
            return NextResponse.json({ error: 'Name, email, and password are required' }, { status: 400 })
        }

        // Check if email exists
        const existingUser = await prisma.user.findUnique({ where: { email } })
        if (existingUser) {
            return NextResponse.json({ error: 'Email already exists' }, { status: 400 })
        }

        // Hash password
        const hashedPassword = await bcrypt.hash(password, 10)

        const user = await prisma.user.create({
            data: {
                name,
                email,
                password: hashedPassword,
                roleId: roleId || 2,
                warehouseId: warehouseId || null,
                campainId: campainId || null,
            },
            select: {
                id: true,
                name: true,
                email: true,
                roleId: true,
                createdAt: true,
            },
        })

        return NextResponse.json(user, { status: 201 })
    } catch (error) {
        console.error('Error creating user:', error)
        return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
    }
}
