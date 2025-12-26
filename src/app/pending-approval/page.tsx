'use client'

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Clock, Mail, LogOut } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'

export default function PendingApprovalPage() {
    const router = useRouter()

    const handleLogout = async () => {
        try {
            await fetch('/api/auth/logout', { method: 'POST' })
            router.push('/login')
        } catch (error) {
            console.error('Logout error:', error)
        }
    }

    return (
        <div className="min-h-screen flex items-center justify-center bg-background p-4">
            <Card className="max-w-md w-full">
                <CardHeader className="text-center">
                    <div className="mx-auto mb-4 h-16 w-16 rounded-full bg-orange-500/10 flex items-center justify-center">
                        <Clock className="h-8 w-8 text-orange-500" />
                    </div>
                    <CardTitle className="text-2xl">Chờ phê duyệt</CardTitle>
                    <CardDescription>
                        Tài khoản của bạn đang chờ quản trị viên phê duyệt
                    </CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                    <div className="bg-muted/50 rounded-lg p-4 space-y-3">
                        <div className="flex items-start gap-3">
                            <Mail className="h-5 w-5 text-muted-foreground mt-0.5" />
                            <div>
                                <p className="font-medium">Liên hệ quản trị viên</p>
                                <p className="text-sm text-muted-foreground">
                                    Vui lòng liên hệ quản trị viên để được kích hoạt tài khoản và gán vào chiến dịch phù hợp.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div className="text-sm text-muted-foreground text-center">
                        <p>Sau khi được phê duyệt, bạn sẽ có thể:</p>
                        <ul className="mt-2 space-y-1">
                            <li>• Truy cập dashboard</li>
                            <li>• Xem và quản lý dữ liệu</li>
                            <li>• Tạo phiếu nhập/xuất kho</li>
                        </ul>
                    </div>

                    <div className="flex flex-col gap-2">
                        <Button variant="outline" onClick={() => router.refresh()}>
                            Kiểm tra lại trạng thái
                        </Button>
                        <Button variant="ghost" onClick={handleLogout} className="text-muted-foreground">
                            <LogOut className="h-4 w-4 mr-2" />
                            Đăng xuất
                        </Button>
                    </div>
                </CardContent>
            </Card>
        </div>
    )
}
