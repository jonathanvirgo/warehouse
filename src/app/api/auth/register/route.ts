import { NextRequest, NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { hashPassword, generateToken, setAuthCookie } from '@/lib/auth'
import { z } from 'zod'

const registerSchema = z.object({
    name: z.string().min(2, 'Tên phải có ít nhất 2 ký tự'),
    email: z.string().email('Email không hợp lệ'),
    password: z.string().min(6, 'Mật khẩu phải có ít nhất 6 ký tự'),
})

export async function POST(request: NextRequest) {
    try {
        const body = await request.json()

        // Validate input
        const result = registerSchema.safeParse(body)
        if (!result.success) {
            return NextResponse.json(
                { error: result.error.issues[0].message },
                { status: 400 }
            )
        }

        const { name, email, password } = result.data

        // Check if user exists
        const existingUser = await prisma.user.findUnique({
            where: { email },
        })

        if (existingUser) {
            return NextResponse.json(
                { error: 'Email đã được sử dụng' },
                { status: 400 }
            )
        }

        // Hash password
        const hashedPassword = await hashPassword(password)

        // Create user
        const user = await prisma.user.create({
            data: {
                name,
                email,
                password: hashedPassword,
                roleId: 2, // Default role
            },
        })

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
            message: 'Đăng ký thành công',
            user: {
                id: user.id,
                name: user.name,
                email: user.email,
                roleId: user.roleId,
            },
        })
    } catch (error) {
        console.error('Register error:', error)
        return NextResponse.json(
            { error: 'Có lỗi xảy ra, vui lòng thử lại' },
            { status: 500 }
        )
    }
}
