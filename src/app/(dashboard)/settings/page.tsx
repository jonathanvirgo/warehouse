'use client'

import { useState, useEffect, useCallback } from 'react'
import { Card, CardContent } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Badge } from '@/components/ui/badge'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from '@/components/ui/dialog'
import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle } from '@/components/ui/alert-dialog'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Plus, Edit, Trash2, Loader2, Search, ArrowUpDown, ChevronLeft, ChevronRight } from 'lucide-react'
import { toast } from '@/hooks/use-toast'
import { formatDate } from '@/lib/utils'

interface Campaign { id: number; name: string; createdAt: string }
interface Warehouse { id: number; name: string; createdAt: string }
interface Brand { id: number; name: string; createdAt: string }
interface User { id: number; name: string; email: string; roleId: number; createdAt: string; warehouse?: { name: string }; campain?: { name: string } }

const ITEMS_PER_PAGE = 10
const ROLES = { ADMIN: 1, USER: 2, GUEST: 3, KHO: 4, XUAT: 5 }
const roleMap: Record<number, string> = {
    1: 'Quản trị viên',
    2: 'Nhân viên',
    3: 'Khách',
    4: 'Nhân viên Kho',
    5: 'Nhân viên Xuất'
}

export default function SettingsPage() {
    // Data states
    const [campaigns, setCampaigns] = useState<Campaign[]>([])
    const [warehouses, setWarehouses] = useState<Warehouse[]>([])
    const [brands, setBrands] = useState<Brand[]>([])
    const [users, setUsers] = useState<User[]>([])
    const [loading, setLoading] = useState(true)
    const [saving, setSaving] = useState(false)
    const [currentUserRoleId, setCurrentUserRoleId] = useState<number>(ROLES.USER)

    // Pagination
    const [campaignPage, setCampaignPage] = useState(1)
    const [warehousePage, setWarehousePage] = useState(1)
    const [brandPage, setBrandPage] = useState(1)
    const [userPage, setUserPage] = useState(1)
    const [campaignTotal, setCampaignTotal] = useState(0)
    const [warehouseTotal, setWarehouseTotal] = useState(0)
    const [brandTotal, setBrandTotal] = useState(0)
    const [userTotal, setUserTotal] = useState(0)

    // Search
    const [campaignSearch, setCampaignSearch] = useState('')
    const [warehouseSearch, setWarehouseSearch] = useState('')
    const [brandSearch, setBrandSearch] = useState('')
    const [userSearch, setUserSearch] = useState('')

    // Sort
    const [sortField, setSortField] = useState('id')
    const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('desc')

    // Dialog states
    const [editCampaign, setEditCampaign] = useState<Campaign | null>(null)
    const [editWarehouse, setEditWarehouse] = useState<Warehouse | null>(null)
    const [editBrand, setEditBrand] = useState<Brand | null>(null)
    const [editUser, setEditUser] = useState<User | null>(null)
    const [deleteItem, setDeleteItem] = useState<{ type: string; id: number; name: string } | null>(null)

    // Form states
    const [campaignForm, setCampaignForm] = useState({ name: '' })
    const [warehouseForm, setWarehouseForm] = useState({ name: '' })
    const [brandForm, setBrandForm] = useState({ name: '' })
    const [userForm, setUserForm] = useState({ name: '', email: '', password: '', roleId: '2', campainId: '' })

    const [isAddCampaign, setIsAddCampaign] = useState(false)
    const [isAddWarehouse, setIsAddWarehouse] = useState(false)
    const [isAddBrand, setIsAddBrand] = useState(false)
    const [isAddUser, setIsAddUser] = useState(false)

    // Fetch functions
    const fetchCampaigns = useCallback(async () => {
        const res = await fetch(`/api/campaigns?page=${campaignPage}&limit=${ITEMS_PER_PAGE}&search=${campaignSearch}&sortBy=${sortField}&sortOrder=${sortOrder}`)
        const data = await res.json()
        setCampaigns(data.data || [])
        setCampaignTotal(data.total || 0)
    }, [campaignPage, campaignSearch, sortField, sortOrder])

    const fetchWarehouses = useCallback(async () => {
        const res = await fetch(`/api/warehouses?page=${warehousePage}&limit=${ITEMS_PER_PAGE}&search=${warehouseSearch}&sortBy=${sortField}&sortOrder=${sortOrder}`)
        const data = await res.json()
        setWarehouses(data.data || [])
        setWarehouseTotal(data.total || 0)
    }, [warehousePage, warehouseSearch, sortField, sortOrder])

    const fetchBrands = useCallback(async () => {
        const res = await fetch(`/api/brands?page=${brandPage}&limit=${ITEMS_PER_PAGE}&search=${brandSearch}&sortBy=${sortField}&sortOrder=${sortOrder}`)
        const data = await res.json()
        setBrands(data.data || [])
        setBrandTotal(data.total || 0)
    }, [brandPage, brandSearch, sortField, sortOrder])

    const fetchUsers = useCallback(async () => {
        const res = await fetch(`/api/users?page=${userPage}&limit=${ITEMS_PER_PAGE}&search=${userSearch}&sortBy=${sortField}&sortOrder=${sortOrder}`)
        const data = await res.json()
        setUsers(data.data || [])
        setUserTotal(data.total || 0)
    }, [userPage, userSearch, sortField, sortOrder])

    useEffect(() => {
        // Fetch current user role
        fetch('/api/auth/me').then(r => r.json()).then(data => {
            if (data.user?.roleId) setCurrentUserRoleId(data.user.roleId)
        }).catch(console.error)

        Promise.all([fetchCampaigns(), fetchWarehouses(), fetchBrands(), fetchUsers()])
            .finally(() => setLoading(false))
    }, [fetchCampaigns, fetchWarehouses, fetchBrands, fetchUsers])

    const isAdmin = currentUserRoleId === ROLES.ADMIN

    const handleSort = (field: string) => {
        if (sortField === field) {
            setSortOrder(prev => prev === 'asc' ? 'desc' : 'asc')
        } else {
            setSortField(field)
            setSortOrder('desc')
        }
    }

    // Campaign CRUD
    const saveCampaign = async () => {
        if (!campaignForm.name) { toast({ title: 'Lỗi', description: 'Vui lòng nhập tên', variant: 'destructive' }); return }
        setSaving(true)
        try {
            if (editCampaign) {
                await fetch(`/api/campaigns/${editCampaign.id}`, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(campaignForm) })
                setEditCampaign(null)
            } else {
                await fetch('/api/campaigns', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(campaignForm) })
                setIsAddCampaign(false)
            }
            setCampaignForm({ name: '' })
            fetchCampaigns()
            toast({ title: 'Thành công', description: editCampaign ? 'Đã cập nhật' : 'Đã thêm mới' })
        } catch { toast({ title: 'Lỗi', variant: 'destructive' }) }
        finally { setSaving(false) }
    }

    // Warehouse CRUD
    const saveWarehouse = async () => {
        if (!warehouseForm.name) { toast({ title: 'Lỗi', description: 'Vui lòng nhập tên', variant: 'destructive' }); return }
        setSaving(true)
        try {
            if (editWarehouse) {
                await fetch(`/api/warehouses/${editWarehouse.id}`, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(warehouseForm) })
                setEditWarehouse(null)
            } else {
                await fetch('/api/warehouses', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(warehouseForm) })
                setIsAddWarehouse(false)
            }
            setWarehouseForm({ name: '' })
            fetchWarehouses()
            toast({ title: 'Thành công', description: editWarehouse ? 'Đã cập nhật' : 'Đã thêm mới' })
        } catch { toast({ title: 'Lỗi', variant: 'destructive' }) }
        finally { setSaving(false) }
    }

    // Brand CRUD
    const saveBrand = async () => {
        if (!brandForm.name) { toast({ title: 'Lỗi', description: 'Vui lòng nhập tên', variant: 'destructive' }); return }
        setSaving(true)
        try {
            if (editBrand) {
                await fetch(`/api/brands/${editBrand.id}`, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(brandForm) })
                setEditBrand(null)
            } else {
                await fetch('/api/brands', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(brandForm) })
                setIsAddBrand(false)
            }
            setBrandForm({ name: '' })
            fetchBrands()
            toast({ title: 'Thành công', description: editBrand ? 'Đã cập nhật' : 'Đã thêm mới' })
        } catch { toast({ title: 'Lỗi', variant: 'destructive' }) }
        finally { setSaving(false) }
    }

    // User CRUD
    const saveUser = async () => {
        if (!userForm.name || !userForm.email) { toast({ title: 'Lỗi', description: 'Vui lòng nhập đầy đủ thông tin', variant: 'destructive' }); return }
        if (!editUser && !userForm.password) { toast({ title: 'Lỗi', description: 'Vui lòng nhập mật khẩu', variant: 'destructive' }); return }
        setSaving(true)
        try {
            const payload: Record<string, unknown> = { name: userForm.name, email: userForm.email, roleId: parseInt(userForm.roleId) }
            if (userForm.password) payload.password = userForm.password
            if (userForm.campainId) payload.campainId = parseInt(userForm.campainId)
            if (editUser) {
                await fetch(`/api/users/${editUser.id}`, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(payload) })
                setEditUser(null)
            } else {
                await fetch('/api/users', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(payload) })
                setIsAddUser(false)
            }
            setUserForm({ name: '', email: '', password: '', roleId: '2', campainId: '' })
            fetchUsers()
            toast({ title: 'Thành công', description: editUser ? 'Đã cập nhật' : 'Đã thêm mới' })
        } catch { toast({ title: 'Lỗi', variant: 'destructive' }) }
        finally { setSaving(false) }
    }

    // Delete handler
    const handleDelete = async () => {
        if (!deleteItem) return
        try {
            await fetch(`/api/${deleteItem.type}s/${deleteItem.id}`, { method: 'DELETE' })
            setDeleteItem(null)
            if (deleteItem.type === 'campaign') fetchCampaigns()
            if (deleteItem.type === 'warehouse') fetchWarehouses()
            if (deleteItem.type === 'brand') fetchBrands()
            if (deleteItem.type === 'user') fetchUsers()
            toast({ title: 'Thành công', description: 'Đã xóa' })
        } catch { toast({ title: 'Lỗi', variant: 'destructive' }) }
    }

    if (loading) {
        return <div className="flex justify-center py-20"><Loader2 className="h-10 w-10 animate-spin text-muted-foreground" /></div>
    }

    const Pagination = ({ page, setPage, total }: { page: number; setPage: (p: number) => void; total: number }) => {
        const totalPages = Math.ceil(total / ITEMS_PER_PAGE)
        if (totalPages <= 1) return null
        return (
            <div className="flex items-center justify-between px-4 py-3 border-t">
                <span className="text-sm text-muted-foreground">Hiển thị {(page - 1) * ITEMS_PER_PAGE + 1}-{Math.min(page * ITEMS_PER_PAGE, total)} / {total}</span>
                <div className="flex gap-1">
                    <Button variant="outline" size="sm" onClick={() => setPage(Math.max(1, page - 1))} disabled={page === 1}><ChevronLeft className="h-4 w-4" /></Button>
                    {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                        const pageNum = page <= 3 ? i + 1 : page + i - 2
                        if (pageNum < 1 || pageNum > totalPages) return null
                        return <Button key={pageNum} variant={page === pageNum ? 'default' : 'outline'} size="sm" onClick={() => setPage(pageNum)}>{pageNum}</Button>
                    })}
                    <Button variant="outline" size="sm" onClick={() => setPage(Math.min(totalPages, page + 1))} disabled={page === totalPages}><ChevronRight className="h-4 w-4" /></Button>
                </div>
            </div>
        )
    }

    return (
        <div className="space-y-6 animate-fade-in">
            <Tabs defaultValue={isAdmin ? "campaigns" : "warehouses"}>
                <TabsList className="flex-wrap">
                    {isAdmin && <TabsTrigger value="campaigns">Chiến dịch</TabsTrigger>}
                    <TabsTrigger value="warehouses">Kho</TabsTrigger>
                    <TabsTrigger value="brands">Thương hiệu</TabsTrigger>
                    {isAdmin && <TabsTrigger value="users">Người dùng</TabsTrigger>}
                </TabsList>

                {/* Campaigns Tab */}
                <TabsContent value="campaigns" className="mt-6 space-y-4">
                    <div className="flex justify-between gap-4">
                        <div className="relative flex-1 max-w-sm">
                            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                            <Input placeholder="Tìm kiếm..." value={campaignSearch} onChange={e => { setCampaignSearch(e.target.value); setCampaignPage(1) }} className="pl-9" />
                        </div>
                        <Button onClick={() => { setCampaignForm({ name: '' }); setIsAddCampaign(true) }}><Plus className="h-4 w-4 mr-2" />Thêm mới</Button>
                    </div>
                    <Card className="border-border/50">
                        <CardContent className="p-0">
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('id')}><div className="flex items-center gap-1">ID <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('name')}><div className="flex items-center gap-1">Tên <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('createdAt')}><div className="flex items-center gap-1">Ngày tạo <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="w-20"></TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {campaigns.length === 0 ? (
                                        <TableRow><TableCell colSpan={4} className="text-center py-8 text-muted-foreground">Không có dữ liệu</TableCell></TableRow>
                                    ) : campaigns.map(c => (
                                        <TableRow key={c.id}>
                                            <TableCell>{c.id}</TableCell>
                                            <TableCell className="font-medium">{c.name}</TableCell>
                                            <TableCell>{formatDate(c.createdAt)}</TableCell>
                                            <TableCell>
                                                <div className="flex gap-1">
                                                    <Button variant="ghost" size="icon" onClick={() => { setEditCampaign(c); setCampaignForm({ name: c.name }) }}><Edit className="h-4 w-4" /></Button>
                                                    <Button variant="ghost" size="icon" onClick={() => setDeleteItem({ type: 'campaign', id: c.id, name: c.name })}><Trash2 className="h-4 w-4 text-destructive" /></Button>
                                                </div>
                                            </TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                            </Table>
                            <Pagination page={campaignPage} setPage={setCampaignPage} total={campaignTotal} />
                        </CardContent>
                    </Card>
                </TabsContent>

                {/* Warehouses Tab */}
                <TabsContent value="warehouses" className="mt-6 space-y-4">
                    <div className="flex justify-between gap-4">
                        <div className="relative flex-1 max-w-sm">
                            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                            <Input placeholder="Tìm kiếm..." value={warehouseSearch} onChange={e => { setWarehouseSearch(e.target.value); setWarehousePage(1) }} className="pl-9" />
                        </div>
                        <Button onClick={() => { setWarehouseForm({ name: '' }); setIsAddWarehouse(true) }}><Plus className="h-4 w-4 mr-2" />Thêm mới</Button>
                    </div>
                    <Card className="border-border/50">
                        <CardContent className="p-0">
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('id')}><div className="flex items-center gap-1">ID <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('name')}><div className="flex items-center gap-1">Tên kho <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('createdAt')}><div className="flex items-center gap-1">Ngày tạo <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="w-20"></TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {warehouses.length === 0 ? (
                                        <TableRow><TableCell colSpan={4} className="text-center py-8 text-muted-foreground">Không có dữ liệu</TableCell></TableRow>
                                    ) : warehouses.map(w => (
                                        <TableRow key={w.id}>
                                            <TableCell>{w.id}</TableCell>
                                            <TableCell className="font-medium">{w.name}</TableCell>
                                            <TableCell>{formatDate(w.createdAt)}</TableCell>
                                            <TableCell>
                                                <div className="flex gap-1">
                                                    <Button variant="ghost" size="icon" onClick={() => { setEditWarehouse(w); setWarehouseForm({ name: w.name }) }}><Edit className="h-4 w-4" /></Button>
                                                    <Button variant="ghost" size="icon" onClick={() => setDeleteItem({ type: 'warehouse', id: w.id, name: w.name })}><Trash2 className="h-4 w-4 text-destructive" /></Button>
                                                </div>
                                            </TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                            </Table>
                            <Pagination page={warehousePage} setPage={setWarehousePage} total={warehouseTotal} />
                        </CardContent>
                    </Card>
                </TabsContent>

                {/* Brands Tab */}
                <TabsContent value="brands" className="mt-6 space-y-4">
                    <div className="flex justify-between gap-4">
                        <div className="relative flex-1 max-w-sm">
                            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                            <Input placeholder="Tìm kiếm..." value={brandSearch} onChange={e => { setBrandSearch(e.target.value); setBrandPage(1) }} className="pl-9" />
                        </div>
                        <Button onClick={() => { setBrandForm({ name: '' }); setIsAddBrand(true) }}><Plus className="h-4 w-4 mr-2" />Thêm mới</Button>
                    </div>
                    <Card className="border-border/50">
                        <CardContent className="p-0">
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('id')}><div className="flex items-center gap-1">ID <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('name')}><div className="flex items-center gap-1">Thương hiệu <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('createdAt')}><div className="flex items-center gap-1">Ngày tạo <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="w-20"></TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {brands.length === 0 ? (
                                        <TableRow><TableCell colSpan={4} className="text-center py-8 text-muted-foreground">Không có dữ liệu</TableCell></TableRow>
                                    ) : brands.map(b => (
                                        <TableRow key={b.id}>
                                            <TableCell>{b.id}</TableCell>
                                            <TableCell className="font-medium">{b.name}</TableCell>
                                            <TableCell>{formatDate(b.createdAt)}</TableCell>
                                            <TableCell>
                                                <div className="flex gap-1">
                                                    <Button variant="ghost" size="icon" onClick={() => { setEditBrand(b); setBrandForm({ name: b.name }) }}><Edit className="h-4 w-4" /></Button>
                                                    <Button variant="ghost" size="icon" onClick={() => setDeleteItem({ type: 'brand', id: b.id, name: b.name })}><Trash2 className="h-4 w-4 text-destructive" /></Button>
                                                </div>
                                            </TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                            </Table>
                            <Pagination page={brandPage} setPage={setBrandPage} total={brandTotal} />
                        </CardContent>
                    </Card>
                </TabsContent>

                {/* Users Tab */}
                <TabsContent value="users" className="mt-6 space-y-4">
                    <div className="flex justify-between gap-4">
                        <div className="relative flex-1 max-w-sm">
                            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                            <Input placeholder="Tìm kiếm..." value={userSearch} onChange={e => { setUserSearch(e.target.value); setUserPage(1) }} className="pl-9" />
                        </div>
                        <Button onClick={() => { setUserForm({ name: '', email: '', password: '', roleId: '2', campainId: '' }); setIsAddUser(true) }}><Plus className="h-4 w-4 mr-2" />Thêm mới</Button>
                    </div>
                    <Card className="border-border/50">
                        <CardContent className="p-0">
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('id')}><div className="flex items-center gap-1">ID <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('name')}><div className="flex items-center gap-1">Tên <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('email')}><div className="flex items-center gap-1">Email <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead>Vai trò</TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('createdAt')}><div className="flex items-center gap-1">Ngày tạo <ArrowUpDown className="h-3 w-3" /></div></TableHead>
                                        <TableHead className="w-20"></TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {users.length === 0 ? (
                                        <TableRow><TableCell colSpan={6} className="text-center py-8 text-muted-foreground">Không có dữ liệu</TableCell></TableRow>
                                    ) : users.map(u => (
                                        <TableRow key={u.id}>
                                            <TableCell>{u.id}</TableCell>
                                            <TableCell className="font-medium">{u.name}</TableCell>
                                            <TableCell>{u.email}</TableCell>
                                            <TableCell><Badge variant="outline">{roleMap[u.roleId] || 'Nhân viên'}</Badge></TableCell>
                                            <TableCell>{formatDate(u.createdAt)}</TableCell>
                                            <TableCell>
                                                <div className="flex gap-1">
                                                    <Button variant="ghost" size="icon" onClick={() => { setEditUser(u); setUserForm({ name: u.name, email: u.email, password: '', roleId: String(u.roleId), campainId: '' }) }}><Edit className="h-4 w-4" /></Button>
                                                    <Button variant="ghost" size="icon" onClick={() => setDeleteItem({ type: 'user', id: u.id, name: u.name })}><Trash2 className="h-4 w-4 text-destructive" /></Button>
                                                </div>
                                            </TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                            </Table>
                            <Pagination page={userPage} setPage={setUserPage} total={userTotal} />
                        </CardContent>
                    </Card>
                </TabsContent>
            </Tabs>

            {/* Campaign Dialog */}
            <Dialog open={isAddCampaign || !!editCampaign} onOpenChange={open => { if (!open) { setIsAddCampaign(false); setEditCampaign(null) } }}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>{editCampaign ? 'Sửa chiến dịch' : 'Thêm chiến dịch'}</DialogTitle>
                        <DialogDescription>Nhập thông tin chiến dịch</DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4">
                        <div className="space-y-2"><Label>Tên chiến dịch *</Label><Input value={campaignForm.name} onChange={e => setCampaignForm({ ...campaignForm, name: e.target.value })} /></div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => { setIsAddCampaign(false); setEditCampaign(null) }}>Hủy</Button>
                        <Button onClick={saveCampaign} disabled={saving}>{saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}Lưu</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* Warehouse Dialog */}
            <Dialog open={isAddWarehouse || !!editWarehouse} onOpenChange={open => { if (!open) { setIsAddWarehouse(false); setEditWarehouse(null) } }}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>{editWarehouse ? 'Sửa kho' : 'Thêm kho'}</DialogTitle>
                        <DialogDescription>Nhập thông tin kho</DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4">
                        <div className="space-y-2"><Label>Tên kho *</Label><Input value={warehouseForm.name} onChange={e => setWarehouseForm({ ...warehouseForm, name: e.target.value })} /></div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => { setIsAddWarehouse(false); setEditWarehouse(null) }}>Hủy</Button>
                        <Button onClick={saveWarehouse} disabled={saving}>{saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}Lưu</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* Brand Dialog */}
            <Dialog open={isAddBrand || !!editBrand} onOpenChange={open => { if (!open) { setIsAddBrand(false); setEditBrand(null) } }}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>{editBrand ? 'Sửa thương hiệu' : 'Thêm thương hiệu'}</DialogTitle>
                        <DialogDescription>Nhập thông tin thương hiệu</DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4">
                        <div className="space-y-2"><Label>Tên thương hiệu *</Label><Input value={brandForm.name} onChange={e => setBrandForm({ ...brandForm, name: e.target.value })} /></div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => { setIsAddBrand(false); setEditBrand(null) }}>Hủy</Button>
                        <Button onClick={saveBrand} disabled={saving}>{saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}Lưu</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* User Dialog */}
            <Dialog open={isAddUser || !!editUser} onOpenChange={open => { if (!open) { setIsAddUser(false); setEditUser(null) } }}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>{editUser ? 'Sửa người dùng' : 'Thêm người dùng'}</DialogTitle>
                        <DialogDescription>Nhập thông tin người dùng</DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4">
                        <div className="space-y-2"><Label>Họ và tên *</Label><Input value={userForm.name} onChange={e => setUserForm({ ...userForm, name: e.target.value })} /></div>
                        <div className="space-y-2"><Label>Email *</Label><Input type="email" value={userForm.email} onChange={e => setUserForm({ ...userForm, email: e.target.value })} /></div>
                        <div className="space-y-2"><Label>Mật khẩu {editUser ? '(để trống nếu không đổi)' : '*'}</Label><Input type="password" value={userForm.password} onChange={e => setUserForm({ ...userForm, password: e.target.value })} /></div>
                        <div className="space-y-2">
                            <Label>Vai trò</Label>
                            <Select value={userForm.roleId} onValueChange={v => setUserForm({ ...userForm, roleId: v })}>
                                <SelectTrigger><SelectValue /></SelectTrigger>
                                <SelectContent className="bg-popover">
                                    <SelectItem value="1">Quản trị viên</SelectItem>
                                    <SelectItem value="2">Nhân viên</SelectItem>
                                    <SelectItem value="3">Khách</SelectItem>
                                    <SelectItem value="4">Nhân viên Kho</SelectItem>
                                    <SelectItem value="5">Nhân viên Xuất</SelectItem>
                                </SelectContent>
                            </Select>
                        </div>
                        <div className="space-y-2">
                            <Label>Chiến dịch</Label>
                            <Select value={userForm.campainId} onValueChange={v => setUserForm({ ...userForm, campainId: v })}>
                                <SelectTrigger><SelectValue placeholder="Chọn chiến dịch" /></SelectTrigger>
                                <SelectContent className="bg-popover">
                                    {campaigns.map(c => <SelectItem key={c.id} value={String(c.id)}>{c.name}</SelectItem>)}
                                </SelectContent>
                            </Select>
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => { setIsAddUser(false); setEditUser(null) }}>Hủy</Button>
                        <Button onClick={saveUser} disabled={saving}>{saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}Lưu</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* Delete Confirmation */}
            <AlertDialog open={!!deleteItem} onOpenChange={open => { if (!open) setDeleteItem(null) }}>
                <AlertDialogContent>
                    <AlertDialogHeader>
                        <AlertDialogTitle>Xác nhận xóa</AlertDialogTitle>
                        <AlertDialogDescription>Bạn có chắc chắn muốn xóa "{deleteItem?.name}"? Hành động này không thể hoàn tác.</AlertDialogDescription>
                    </AlertDialogHeader>
                    <AlertDialogFooter>
                        <AlertDialogCancel>Hủy</AlertDialogCancel>
                        <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">Xóa</AlertDialogAction>
                    </AlertDialogFooter>
                </AlertDialogContent>
            </AlertDialog>
        </div>
    )
}
