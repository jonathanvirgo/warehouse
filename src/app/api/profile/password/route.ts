import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import bcrypt from 'bcryptjs'
import { getCurrentUser } from '@/lib/auth'

// PUT /api/profile/password - Change password
export async function PUT(request: NextRequest) {
    try {
        const payload = await getCurrentUser()
        if (!payload) {
            return NextResponse.json({ error: 'Chưa đăng nhập' }, { status: 401 })
        }

        const body = await request.json()
        const { currentPassword, newPassword } = body

        if (!currentPassword || !newPassword) {
            return NextResponse.json({ error: 'Vui lòng nhập đầy đủ thông tin' }, { status: 400 })
        }

        if (newPassword.length < 6) {
            return NextResponse.json({ error: 'Mật khẩu mới phải có ít nhất 6 ký tự' }, { status: 400 })
        }

        // Get user with password
        const user = await prisma.user.findUnique({
            where: { id: payload.userId },
            select: { password: true },
        })

        if (!user) {
            return NextResponse.json({ error: 'Người dùng không tồn tại' }, { status: 404 })
        }

        // Verify current password
        const isValid = await bcrypt.compare(currentPassword, user.password)
        if (!isValid) {
            return NextResponse.json({ error: 'Mật khẩu hiện tại không đúng' }, { status: 400 })
        }

        // Hash new password and update
        const hashedPassword = await bcrypt.hash(newPassword, 10)
        await prisma.user.update({
            where: { id: payload.userId },
            data: { password: hashedPassword },
        })

        return NextResponse.json({ message: 'Đổi mật khẩu thành công' })
    } catch (error) {
        console.error('Change password error:', error)
        return NextResponse.json({ error: 'Có lỗi xảy ra' }, { status: 500 })
    }
}
