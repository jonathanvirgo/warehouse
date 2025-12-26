import { NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

export async function GET() {
    try {
        const payload = await getCurrentUser()

        if (!payload) {
            return NextResponse.json(
                { error: 'Chưa đăng nhập' },
                { status: 401 }
            )
        }

        const user = await prisma.user.findUnique({
            where: { id: payload.userId },
            select: {
                id: true,
                name: true,
                email: true,
                avatar: true,
                roleId: true,
                campainId: true,
                warehouseId: true,
                role: {
                    select: {
                        id: true,
                        name: true,
                        displayName: true,
                    },
                },
                campain: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
                warehouse: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        })

        if (!user) {
            return NextResponse.json(
                { error: 'Người dùng không tồn tại' },
                { status: 404 }
            )
        }

        return NextResponse.json({ user })
    } catch (error) {
        console.error('Get current user error:', error)
        return NextResponse.json(
            { error: 'Có lỗi xảy ra' },
            { status: 500 }
        )
    }
}
