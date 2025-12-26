'use client'

import { useState, useEffect, useCallback } from 'react'
import { Plus, Search, MoreHorizontal, Edit, Trash2, Eye, ChevronLeft, ChevronRight, Loader2 } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from '@/components/ui/dialog'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle } from '@/components/ui/alert-dialog'
import { toast } from '@/hooks/use-toast'

interface Brand {
    id: number
    name: string
}

interface Product {
    id: number
    name: string
    image: string | null
    brand: Brand | null
    brandId: number | null
    createdAt: string
}

const ITEMS_PER_PAGE = 10

export default function ProductsPage() {
    const [search, setSearch] = useState('')
    const [filterBrand, setFilterBrand] = useState('all')
    const [products, setProducts] = useState<Product[]>([])
    const [brands, setBrands] = useState<Brand[]>([])
    const [loading, setLoading] = useState(true)
    const [currentPage, setCurrentPage] = useState(1)
    const [totalPages, setTotalPages] = useState(1)
    const [total, setTotal] = useState(0)

    const [isAddOpen, setIsAddOpen] = useState(false)
    const [isEditOpen, setIsEditOpen] = useState(false)
    const [isViewOpen, setIsViewOpen] = useState(false)
    const [isDeleteOpen, setIsDeleteOpen] = useState(false)
    const [selectedProduct, setSelectedProduct] = useState<Product | null>(null)
    const [saving, setSaving] = useState(false)

    const [formData, setFormData] = useState({
        name: '',
        brandId: '',
        image: '',
    })

    // Fetch brands
    useEffect(() => {
        fetch('/api/brands')
            .then(res => res.json())
            .then(data => setBrands(data.data || []))
            .catch(console.error)
    }, [])

    // Fetch products
    const fetchProducts = useCallback(async () => {
        setLoading(true)
        try {
            const params = new URLSearchParams({
                page: String(currentPage),
                limit: String(ITEMS_PER_PAGE),
                ...(search && { search }),
                ...(filterBrand !== 'all' && { brandId: filterBrand }),
            })
            const res = await fetch(`/api/products?${params}`)
            const data = await res.json()
            setProducts(data.data || [])
            setTotal(data.total || 0)
            setTotalPages(data.totalPages || 1)
        } catch (error) {
            console.error('Error fetching products:', error)
            toast({ title: 'Lỗi', description: 'Không thể tải danh sách sản phẩm', variant: 'destructive' })
        } finally {
            setLoading(false)
        }
    }, [currentPage, search, filterBrand])

    useEffect(() => {
        fetchProducts()
    }, [fetchProducts])

    const resetForm = () => {
        setFormData({ name: '', brandId: '', image: '' })
    }

    const handleAdd = async () => {
        if (!formData.name.trim()) {
            toast({ title: 'Lỗi', description: 'Vui lòng nhập tên sản phẩm', variant: 'destructive' })
            return
        }
        setSaving(true)
        try {
            const res = await fetch('/api/products', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData),
            })
            if (!res.ok) throw new Error('Failed to create product')
            setIsAddOpen(false)
            resetForm()
            fetchProducts()
            toast({ title: 'Thành công', description: 'Đã thêm sản phẩm mới' })
        } catch {
            toast({ title: 'Lỗi', description: 'Không thể thêm sản phẩm', variant: 'destructive' })
        } finally {
            setSaving(false)
        }
    }

    const handleEdit = async () => {
        if (!selectedProduct) return
        setSaving(true)
        try {
            const res = await fetch(`/api/products/${selectedProduct.id}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData),
            })
            if (!res.ok) throw new Error('Failed to update product')
            setIsEditOpen(false)
            setSelectedProduct(null)
            resetForm()
            fetchProducts()
            toast({ title: 'Thành công', description: 'Đã cập nhật sản phẩm' })
        } catch {
            toast({ title: 'Lỗi', description: 'Không thể cập nhật sản phẩm', variant: 'destructive' })
        } finally {
            setSaving(false)
        }
    }

    const handleDelete = async () => {
        if (!selectedProduct) return
        setSaving(true)
        try {
            const res = await fetch(`/api/products/${selectedProduct.id}`, { method: 'DELETE' })
            if (!res.ok) throw new Error('Failed to delete product')
            setIsDeleteOpen(false)
            setSelectedProduct(null)
            fetchProducts()
            toast({ title: 'Thành công', description: 'Đã xóa sản phẩm' })
        } catch {
            toast({ title: 'Lỗi', description: 'Không thể xóa sản phẩm', variant: 'destructive' })
        } finally {
            setSaving(false)
        }
    }

    const openEdit = (product: Product) => {
        setSelectedProduct(product)
        setFormData({
            name: product.name,
            brandId: product.brandId ? String(product.brandId) : '',
            image: product.image || '',
        })
        setIsEditOpen(true)
    }

    const openView = (product: Product) => {
        setSelectedProduct(product)
        setIsViewOpen(true)
    }

    const openDelete = (product: Product) => {
        setSelectedProduct(product)
        setIsDeleteOpen(true)
    }

    return (
        <div className="space-y-6 animate-fade-in">
            {/* Filter Bar */}
            <Card className="border-border/50">
                <CardContent className="py-4">
                    <div className="flex flex-wrap items-end gap-4">
                        <div className="space-y-1 min-w-[180px]">
                            <Label className="text-xs text-muted-foreground">Thương hiệu</Label>
                            <Select value={filterBrand} onValueChange={(v) => { setFilterBrand(v); setCurrentPage(1) }}>
                                <SelectTrigger><SelectValue /></SelectTrigger>
                                <SelectContent className="bg-popover">
                                    <SelectItem value="all">Tất cả thương hiệu</SelectItem>
                                    {brands.map(b => (
                                        <SelectItem key={b.id} value={String(b.id)}>{b.name}</SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                        <div className="space-y-1 flex-1 min-w-[200px]">
                            <Label className="text-xs text-muted-foreground">Tìm kiếm</Label>
                            <div className="relative">
                                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                                <Input
                                    placeholder="Tìm sản phẩm..."
                                    value={search}
                                    onChange={(e) => { setSearch(e.target.value); setCurrentPage(1) }}
                                    className="pl-9"
                                />
                            </div>
                        </div>
                        <Button onClick={() => { resetForm(); setIsAddOpen(true) }}>
                            <Plus className="h-4 w-4 mr-2" />Thêm sản phẩm
                        </Button>
                    </div>
                </CardContent>
            </Card>

            <Card className="border-border/50">
                <CardHeader className="pb-3">
                    <CardTitle>Danh sách sản phẩm ({total})</CardTitle>
                </CardHeader>
                <CardContent className="p-0">
                    {loading ? (
                        <div className="flex justify-center py-12">
                            <Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
                        </div>
                    ) : (
                        <>
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead>ID</TableHead>
                                        <TableHead>Tên sản phẩm</TableHead>
                                        <TableHead>Thương hiệu</TableHead>
                                        <TableHead>Ngày tạo</TableHead>
                                        <TableHead className="w-10"></TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {products.length === 0 ? (
                                        <TableRow>
                                            <TableCell colSpan={5} className="text-center py-8 text-muted-foreground">
                                                Không có sản phẩm nào
                                            </TableCell>
                                        </TableRow>
                                    ) : (
                                        products.map((product) => (
                                            <TableRow key={product.id}>
                                                <TableCell className="font-medium">{product.id}</TableCell>
                                                <TableCell>{product.name}</TableCell>
                                                <TableCell>{product.brand?.name || '-'}</TableCell>
                                                <TableCell>{new Date(product.createdAt).toLocaleDateString('vi-VN')}</TableCell>
                                                <TableCell>
                                                    <DropdownMenu>
                                                        <DropdownMenuTrigger asChild>
                                                            <Button variant="ghost" size="icon"><MoreHorizontal className="h-4 w-4" /></Button>
                                                        </DropdownMenuTrigger>
                                                        <DropdownMenuContent align="end" className="bg-popover">
                                                            <DropdownMenuItem onClick={() => openView(product)}><Eye className="h-4 w-4 mr-2" />Xem</DropdownMenuItem>
                                                            <DropdownMenuItem onClick={() => openEdit(product)}><Edit className="h-4 w-4 mr-2" />Sửa</DropdownMenuItem>
                                                            <DropdownMenuItem onClick={() => openDelete(product)} className="text-destructive"><Trash2 className="h-4 w-4 mr-2" />Xóa</DropdownMenuItem>
                                                        </DropdownMenuContent>
                                                    </DropdownMenu>
                                                </TableCell>
                                            </TableRow>
                                        ))
                                    )}
                                </TableBody>
                            </Table>

                            {/* Pagination */}
                            {totalPages > 1 && (
                                <div className="flex items-center justify-between px-6 py-4 border-t border-border">
                                    <span className="text-sm text-muted-foreground">
                                        Trang {currentPage} / {totalPages} ({total} sản phẩm)
                                    </span>
                                    <div className="flex items-center gap-2">
                                        <Button variant="outline" size="sm" onClick={() => setCurrentPage(p => Math.max(1, p - 1))} disabled={currentPage === 1}>
                                            <ChevronLeft className="h-4 w-4" />
                                        </Button>
                                        <Button variant="outline" size="sm" onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))} disabled={currentPage === totalPages}>
                                            <ChevronRight className="h-4 w-4" />
                                        </Button>
                                    </div>
                                </div>
                            )}
                        </>
                    )}
                </CardContent>
            </Card>

            {/* Add Product Dialog */}
            <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>Thêm sản phẩm mới</DialogTitle>
                        <DialogDescription>Nhập thông tin sản phẩm cần thêm</DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4">
                        <div className="space-y-2">
                            <Label>Tên sản phẩm *</Label>
                            <Input value={formData.name} onChange={(e) => setFormData({ ...formData, name: e.target.value })} placeholder="Nhập tên sản phẩm" />
                        </div>
                        <div className="space-y-2">
                            <Label>Thương hiệu</Label>
                            <Select value={formData.brandId} onValueChange={(v) => setFormData({ ...formData, brandId: v })}>
                                <SelectTrigger><SelectValue placeholder="Chọn thương hiệu" /></SelectTrigger>
                                <SelectContent className="bg-popover">
                                    {brands.map(b => (
                                        <SelectItem key={b.id} value={String(b.id)}>{b.name}</SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                        <div className="space-y-2">
                            <Label>Link ảnh</Label>
                            <Input value={formData.image} onChange={(e) => setFormData({ ...formData, image: e.target.value })} placeholder="https://..." />
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setIsAddOpen(false)}>Hủy</Button>
                        <Button onClick={handleAdd} disabled={saving}>
                            {saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}
                            Thêm
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* Edit Product Dialog */}
            <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>Sửa sản phẩm</DialogTitle>
                        <DialogDescription>Cập nhật thông tin sản phẩm</DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4">
                        <div className="space-y-2">
                            <Label>Tên sản phẩm *</Label>
                            <Input value={formData.name} onChange={(e) => setFormData({ ...formData, name: e.target.value })} />
                        </div>
                        <div className="space-y-2">
                            <Label>Thương hiệu</Label>
                            <Select value={formData.brandId} onValueChange={(v) => setFormData({ ...formData, brandId: v })}>
                                <SelectTrigger><SelectValue /></SelectTrigger>
                                <SelectContent className="bg-popover">
                                    {brands.map(b => (
                                        <SelectItem key={b.id} value={String(b.id)}>{b.name}</SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                        <div className="space-y-2">
                            <Label>Link ảnh</Label>
                            <Input value={formData.image} onChange={(e) => setFormData({ ...formData, image: e.target.value })} />
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setIsEditOpen(false)}>Hủy</Button>
                        <Button onClick={handleEdit} disabled={saving}>
                            {saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}
                            Lưu
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* View Product Dialog */}
            <Dialog open={isViewOpen} onOpenChange={setIsViewOpen}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>Chi tiết sản phẩm</DialogTitle>
                    </DialogHeader>
                    {selectedProduct && (
                        <div className="space-y-3">
                            <div className="flex justify-between"><span className="text-muted-foreground">ID:</span><span className="font-medium">{selectedProduct.id}</span></div>
                            <div className="flex justify-between"><span className="text-muted-foreground">Tên:</span><span className="font-medium">{selectedProduct.name}</span></div>
                            <div className="flex justify-between"><span className="text-muted-foreground">Thương hiệu:</span><span>{selectedProduct.brand?.name || '-'}</span></div>
                            <div className="flex justify-between"><span className="text-muted-foreground">Ngày tạo:</span><span>{new Date(selectedProduct.createdAt).toLocaleDateString('vi-VN')}</span></div>
                        </div>
                    )}
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setIsViewOpen(false)}>Đóng</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* Delete Confirmation */}
            <AlertDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen}>
                <AlertDialogContent>
                    <AlertDialogHeader>
                        <AlertDialogTitle>Xác nhận xóa</AlertDialogTitle>
                        <AlertDialogDescription>
                            Bạn có chắc chắn muốn xóa sản phẩm &ldquo;{selectedProduct?.name}&rdquo;? Hành động này không thể hoàn tác.
                        </AlertDialogDescription>
                    </AlertDialogHeader>
                    <AlertDialogFooter>
                        <AlertDialogCancel>Hủy</AlertDialogCancel>
                        <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90" disabled={saving}>
                            {saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}
                            Xóa
                        </AlertDialogAction>
                    </AlertDialogFooter>
                </AlertDialogContent>
            </AlertDialog>
        </div>
    )
}
