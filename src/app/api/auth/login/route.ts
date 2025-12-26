import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { verifyPassword, generateToken, setAuthCookie } from '@/lib/auth'
import { z } from 'zod'

const loginSchema = z.object({
    email: z.string().email('Email không hợp lệ'),
    password: z.string().min(1, 'Vui lòng nhập mật khẩu'),
})

export async function POST(request: NextRequest) {
    try {
        const body = await request.json()

        // Validate input
        const result = loginSchema.safeParse(body)
        if (!result.success) {
            return NextResponse.json(
                { error: result.error.issues[0].message },
                { status: 400 }
            )
        }

        const { email, password } = result.data

        // Find user
        const user = await prisma.user.findUnique({
            where: { email },
            include: {
                campain: true,
                warehouse: true,
            },
        })

        if (!user) {
            return NextResponse.json(
                { error: 'Email hoặc mật khẩu không chính xác' },
                { status: 401 }
            )
        }

        // Verify password
        const isValid = await verifyPassword(password, user.password)
        if (!isValid) {
            return NextResponse.json(
                { error: 'Email hoặc mật khẩu không chính xác' },
                { status: 401 }
            )
        }

        // Generate token
        const token = generateToken({
            userId: user.id,
            email: user.email,
            roleId: user.roleId,
            campainId: user.campainId ?? undefined,
            warehouseId: user.warehouseId ?? undefined,
        })

        // Set cookie
        await setAuthCookie(token)

        return NextResponse.json({
            message: 'Đăng nhập thành công',
            user: {
                id: user.id,
                name: user.name,
                email: user.email,
                roleId: user.roleId,
                campain: user.campain,
                warehouse: user.warehouse,
            },
        })
    } catch (error) {
        console.error('Login error:', error)
        return NextResponse.json(
            { error: 'Có lỗi xảy ra, vui lòng thử lại' },
            { status: 500 }
        )
    }
}
