'use client'

import { useState, useEffect } from 'react'
import { User, Mail, Lock, Save, Loader2, Key } from 'lucide-react'
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar'
import { Separator } from '@/components/ui/separator'
import { toast } from '@/hooks/use-toast'

interface UserProfile {
    id: number
    name: string
    email: string
    avatar: string | null
    roleId: number
    role?: { name: string; displayName: string }
    campain?: { name: string }
    warehouse?: { name: string }
}

const roleNames: Record<number, string> = {
    1: 'Quản trị viên',
    2: 'Nhân viên',
    3: 'Khách',
    4: 'Nhân viên Kho',
    5: 'Nhân viên Xuất',
}

export default function ProfilePage() {
    const [user, setUser] = useState<UserProfile | null>(null)
    const [loading, setLoading] = useState(true)
    const [saving, setSaving] = useState(false)
    const [savingPassword, setSavingPassword] = useState(false)
    const [name, setName] = useState('')

    // Password change
    const [currentPassword, setCurrentPassword] = useState('')
    const [newPassword, setNewPassword] = useState('')
    const [confirmPassword, setConfirmPassword] = useState('')

    useEffect(() => {
        fetch('/api/auth/me')
            .then(res => res.json())
            .then(data => {
                setUser(data.user)
                setName(data.user?.name || '')
            })
            .catch(console.error)
            .finally(() => setLoading(false))
    }, [])

    const handleSave = async () => {
        if (!name.trim()) {
            toast({ title: 'Lỗi', description: 'Vui lòng nhập tên', variant: 'destructive' })
            return
        }
        setSaving(true)
        try {
            const res = await fetch('/api/profile', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name }),
            })
            if (!res.ok) throw new Error('Failed')
            toast({ title: 'Thành công', description: 'Đã cập nhật thông tin' })
        } catch {
            toast({ title: 'Lỗi', description: 'Không thể cập nhật', variant: 'destructive' })
        } finally {
            setSaving(false)
        }
    }

    const handleChangePassword = async () => {
        if (!currentPassword || !newPassword || !confirmPassword) {
            toast({ title: 'Lỗi', description: 'Vui lòng nhập đầy đủ thông tin', variant: 'destructive' })
            return
        }
        if (newPassword.length < 6) {
            toast({ title: 'Lỗi', description: 'Mật khẩu mới phải có ít nhất 6 ký tự', variant: 'destructive' })
            return
        }
        if (newPassword !== confirmPassword) {
            toast({ title: 'Lỗi', description: 'Mật khẩu mới không khớp', variant: 'destructive' })
            return
        }
        setSavingPassword(true)
        try {
            const res = await fetch('/api/profile/password', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ currentPassword, newPassword }),
            })
            const data = await res.json()
            if (!res.ok) {
                throw new Error(data.error || 'Failed')
            }
            toast({ title: 'Thành công', description: 'Đã đổi mật khẩu' })
            setCurrentPassword('')
            setNewPassword('')
            setConfirmPassword('')
        } catch (error) {
            toast({ title: 'Lỗi', description: error instanceof Error ? error.message : 'Không thể đổi mật khẩu', variant: 'destructive' })
        } finally {
            setSavingPassword(false)
        }
    }

    if (loading) {
        return (
            <div className="flex justify-center py-20">
                <Loader2 className="h-10 w-10 animate-spin text-muted-foreground" />
            </div>
        )
    }

    return (
        <div className="max-w-2xl mx-auto space-y-6 animate-fade-in">
            {/* Profile Info */}
            <Card className="border-border/50">
                <CardHeader>
                    <CardTitle>Hồ sơ cá nhân</CardTitle>
                    <CardDescription>Xem và chỉnh sửa thông tin tài khoản</CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                    {/* Avatar */}
                    <div className="flex items-center gap-4">
                        <Avatar className="h-20 w-20">
                            <AvatarImage src={user?.avatar || ''} />
                            <AvatarFallback className="text-2xl bg-primary text-primary-foreground">
                                {user?.name?.charAt(0).toUpperCase() || 'U'}
                            </AvatarFallback>
                        </Avatar>
                        <div>
                            <h3 className="text-xl font-semibold">{user?.name}</h3>
                            <p className="text-muted-foreground">{user?.role?.displayName || roleNames[user?.roleId || 2]}</p>
                        </div>
                    </div>

                    {/* Form */}
                    <div className="space-y-4">
                        <div className="space-y-2">
                            <Label className="flex items-center gap-2">
                                <User className="h-4 w-4" /> Họ tên
                            </Label>
                            <Input value={name} onChange={e => setName(e.target.value)} />
                        </div>

                        <div className="space-y-2">
                            <Label className="flex items-center gap-2">
                                <Mail className="h-4 w-4" /> Email
                            </Label>
                            <Input value={user?.email || ''} disabled className="bg-muted" />
                        </div>

                        {user?.campain && (
                            <div className="space-y-2">
                                <Label>Chiến dịch</Label>
                                <Input value={user.campain.name} disabled className="bg-muted" />
                            </div>
                        )}

                        {user?.warehouse && (
                            <div className="space-y-2">
                                <Label>Kho</Label>
                                <Input value={user.warehouse.name} disabled className="bg-muted" />
                            </div>
                        )}
                    </div>

                    <Button onClick={handleSave} disabled={saving}>
                        {saving ? <Loader2 className="h-4 w-4 mr-2 animate-spin" /> : <Save className="h-4 w-4 mr-2" />}
                        Lưu thay đổi
                    </Button>
                </CardContent>
            </Card>

            {/* Change Password */}
            <Card className="border-border/50">
                <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                        <Key className="h-5 w-5" /> Đổi mật khẩu
                    </CardTitle>
                    <CardDescription>Thay đổi mật khẩu đăng nhập của bạn</CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                    <div className="space-y-2">
                        <Label className="flex items-center gap-2">
                            <Lock className="h-4 w-4" /> Mật khẩu hiện tại
                        </Label>
                        <Input
                            type="password"
                            value={currentPassword}
                            onChange={e => setCurrentPassword(e.target.value)}
                            placeholder="Nhập mật khẩu hiện tại"
                        />
                    </div>

                    <Separator />

                    <div className="space-y-2">
                        <Label className="flex items-center gap-2">
                            <Lock className="h-4 w-4" /> Mật khẩu mới
                        </Label>
                        <Input
                            type="password"
                            value={newPassword}
                            onChange={e => setNewPassword(e.target.value)}
                            placeholder="Nhập mật khẩu mới (ít nhất 6 ký tự)"
                        />
                    </div>

                    <div className="space-y-2">
                        <Label className="flex items-center gap-2">
                            <Lock className="h-4 w-4" /> Xác nhận mật khẩu mới
                        </Label>
                        <Input
                            type="password"
                            value={confirmPassword}
                            onChange={e => setConfirmPassword(e.target.value)}
                            placeholder="Nhập lại mật khẩu mới"
                        />
                    </div>

                    <Button onClick={handleChangePassword} disabled={savingPassword} variant="outline">
                        {savingPassword ? <Loader2 className="h-4 w-4 mr-2 animate-spin" /> : <Key className="h-4 w-4 mr-2" />}
                        Đổi mật khẩu
                    </Button>
                </CardContent>
            </Card>
        </div>
    )
}
