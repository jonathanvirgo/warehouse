import { NextResponse } from 'next/server'
import { removeAuthCookie } from '@/lib/auth'

export async function POST() {
    try {
        await removeAuthCookie()

        return NextResponse.json({
            message: 'Đăng xuất thành công',
        })
    } catch (error) {
        console.error('Logout error:', error)
        return NextResponse.json(
            { error: 'Có lỗi xảy ra' },
            { status: 500 }
        )
    }
}
