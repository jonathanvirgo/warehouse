import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { getCurrentUser } from '@/lib/auth'

// PUT /api/profile - Cập nhật profile
export async function PUT(request: NextRequest) {
    try {
        const currentUser = await getCurrentUser()
        if (!currentUser) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
        }

        const body = await request.json()
        const { name, avatar } = body

        const user = await prisma.user.update({
            where: { id: currentUser.userId },
            data: {
                ...(name && { name }),
                ...(avatar && { avatar }),
            },
            select: {
                id: true,
                name: true,
                email: true,
                avatar: true,
                roleId: true,
            },
        })

        return NextResponse.json({ data: user })
    } catch (error) {
        console.error('Update profile error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
