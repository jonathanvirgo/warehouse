'use client'

import { useState, useMemo, useEffect } from 'react'
import { Plus, Trash2, ArrowUpDown, X, Search, Download, Loader2 } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow, TableFooter } from '@/components/ui/table'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { toast } from '@/hooks/use-toast'
import { formatCurrency, formatDate } from '@/lib/utils'
import { exportToExcel, downloadExcel, formatExportsForExcel, EXPORT_COLUMNS } from '@/lib/excel'

interface Product {
    id: number
    name: string
    sellPrice?: number
}

interface Warehouse {
    id: number
    name: string
}

interface ExportRecord {
    id: number
    proId: number
    product: Product
    warehouse: Warehouse
    total: number
    price: number
    income: number
    reportDate: string
    note: string | null
    user?: { name: string }
}

interface ExportItem {
    productId: string
    productName: string
    quantity: number
    unitPrice: number
}

type SortField = 'date' | 'amount' | 'product' | 'warehouse'
type SortDirection = 'asc' | 'desc'

export default function ExportsPage() {
    const [exports, setExports] = useState<ExportRecord[]>([])
    const [products, setProducts] = useState<Product[]>([])
    const [warehouses, setWarehouses] = useState<Warehouse[]>([])
    const [loading, setLoading] = useState(true)

    const [search, setSearch] = useState('')
    const [isCreating, setIsCreating] = useState(false)
    const [viewMode, setViewMode] = useState<'products' | 'entries'>('products')

    const [filterProduct, setFilterProduct] = useState('all')
    const [filterWarehouse, setFilterWarehouse] = useState('all')
    const [sortField, setSortField] = useState<SortField>('date')
    const [sortDirection, setSortDirection] = useState<SortDirection>('desc')

    const [items, setItems] = useState<ExportItem[]>([])
    const [formData, setFormData] = useState({
        warehouseId: '',
        date: new Date().toISOString().split('T')[0],
        note: '',
    })
    const [currentItem, setCurrentItem] = useState({
        productId: '',
        quantity: '',
        unitPrice: '',
    })
    const [saving, setSaving] = useState(false)

    // Fetch data
    useEffect(() => {
        Promise.all([
            fetch('/api/products?limit=100').then(r => r.json()),
            fetch('/api/warehouses').then(r => r.json()),
            fetch('/api/exports?limit=100').then(r => r.json()),
        ]).then(([productsData, warehousesData, exportsData]) => {
            setProducts(productsData.data || [])
            setWarehouses(warehousesData.data || [])
            setExports(exportsData.data || [])
            setLoading(false)
        }).catch(err => {
            console.error(err)
            setLoading(false)
        })
    }, [])

    // Filtered and sorted data
    const filteredExports = useMemo(() => {
        let result = [...exports]

        if (filterProduct !== 'all') {
            result = result.filter(e => String(e.proId) === filterProduct)
        }
        if (filterWarehouse !== 'all') {
            result = result.filter(e => String(e.warehouse?.id) === filterWarehouse)
        }
        if (search) {
            result = result.filter(e =>
                e.product?.name?.toLowerCase().includes(search.toLowerCase())
            )
        }

        // Sort
        result.sort((a, b) => {
            let comparison = 0
            switch (sortField) {
                case 'date':
                    comparison = (a.reportDate || '').localeCompare(b.reportDate || '')
                    break
                case 'amount':
                    comparison = a.income - b.income
                    break
                case 'product':
                    comparison = (a.product?.name || '').localeCompare(b.product?.name || '')
                    break
                case 'warehouse':
                    comparison = (a.warehouse?.name || '').localeCompare(b.warehouse?.name || '')
                    break
            }
            return sortDirection === 'asc' ? comparison : -comparison
        })

        return result
    }, [exports, filterProduct, filterWarehouse, search, sortField, sortDirection])

    const totalIncome = filteredExports.reduce((sum, item) => sum + (item.income || 0), 0)

    const handleSort = (field: SortField) => {
        if (sortField === field) {
            setSortDirection(prev => prev === 'asc' ? 'desc' : 'asc')
        } else {
            setSortField(field)
            setSortDirection('desc')
        }
    }

    const clearFilters = () => {
        setFilterProduct('all')
        setFilterWarehouse('all')
        setSearch('')
    }

    const hasActiveFilters = filterProduct !== 'all' || filterWarehouse !== 'all' || search

    const handleExportExcel = () => {
        if (filteredExports.length === 0) {
            toast({ title: 'Lỗi', description: 'Không có dữ liệu để xuất', variant: 'destructive' })
            return
        }
        const formattedData = formatExportsForExcel(filteredExports as Parameters<typeof formatExportsForExcel>[0])
        const blob = exportToExcel(formattedData, EXPORT_COLUMNS, 'xuat-kho')
        downloadExcel(blob, `xuat-kho-${new Date().toISOString().split('T')[0]}`)
        toast({ title: 'Thành công', description: `Đã xuất ${filteredExports.length} bản ghi` })
    }

    const addItem = () => {
        if (!currentItem.productId || !currentItem.quantity) {
            toast({ title: 'Lỗi', description: 'Vui lòng điền đầy đủ thông tin sản phẩm', variant: 'destructive' })
            return
        }
        const product = products.find(p => String(p.id) === currentItem.productId)
        if (!product) return

        setItems([...items, {
            productId: currentItem.productId,
            productName: product.name,
            quantity: Number(currentItem.quantity),
            unitPrice: Number(currentItem.unitPrice) || product.sellPrice || 0,
        }])
        setCurrentItem({ productId: '', quantity: '', unitPrice: '' })
    }

    const removeItem = (index: number) => {
        setItems(items.filter((_, i) => i !== index))
    }

    const handleSave = async () => {
        if (!formData.warehouseId || items.length === 0) {
            toast({ title: 'Lỗi', description: 'Vui lòng chọn kho và thêm ít nhất 1 sản phẩm', variant: 'destructive' })
            return
        }

        setSaving(true)
        try {
            // Save each item as a separate export record
            for (const item of items) {
                await fetch('/api/exports', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        proId: item.productId,
                        warehouseId: formData.warehouseId,
                        total: item.quantity,
                        price: item.unitPrice,
                        reportDate: new Date(formData.date).toISOString(),
                        note: formData.note,
                    }),
                })
            }

            setIsCreating(false)
            setItems([])
            setFormData({ warehouseId: '', date: new Date().toISOString().split('T')[0], note: '' })
            toast({ title: 'Thành công', description: 'Đã tạo xuất kho' })

            // Refresh data
            const res = await fetch('/api/exports?limit=100')
            const data = await res.json()
            setExports(data.data || [])
        } catch {
            toast({ title: 'Lỗi', description: 'Không thể tạo xuất kho', variant: 'destructive' })
        } finally {
            setSaving(false)
        }
    }

    // When selecting product, auto-fill sell price
    const handleProductSelect = (productId: string) => {
        const product = products.find(p => String(p.id) === productId)
        setCurrentItem({
            ...currentItem,
            productId,
            unitPrice: product?.sellPrice ? String(product.sellPrice) : '',
        })
    }

    if (loading) {
        return (
            <div className="flex justify-center py-20">
                <Loader2 className="h-10 w-10 animate-spin text-muted-foreground" />
            </div>
        )
    }

    if (isCreating) {
        return (
            <div className="space-y-6 animate-fade-in">
                <div className="flex items-center justify-between">
                    <h2 className="text-2xl font-bold">Tạo xuất kho</h2>
                    <Button variant="outline" onClick={() => setIsCreating(false)}>Hủy</Button>
                </div>

                <Card className="border-border/50">
                    <CardHeader><CardTitle>Thông tin xuất kho</CardTitle></CardHeader>
                    <CardContent className="space-y-4">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div className="space-y-2">
                                <Label>Kho xuất</Label>
                                <Select value={formData.warehouseId} onValueChange={(v) => setFormData({ ...formData, warehouseId: v })}>
                                    <SelectTrigger><SelectValue placeholder="Chọn kho" /></SelectTrigger>
                                    <SelectContent className="bg-popover">
                                        {warehouses.map(w => (
                                            <SelectItem key={w.id} value={String(w.id)}>{w.name}</SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                            <div className="space-y-2">
                                <Label>Ngày xuất</Label>
                                <Input type="date" value={formData.date} onChange={(e) => setFormData({ ...formData, date: e.target.value })} />
                            </div>
                        </div>
                        <div className="space-y-2">
                            <Label>Ghi chú</Label>
                            <Textarea value={formData.note} onChange={(e) => setFormData({ ...formData, note: e.target.value })} placeholder="Nhập ghi chú..." />
                        </div>
                    </CardContent>
                </Card>

                <Card className="border-border/50">
                    <CardHeader><CardTitle>Thêm sản phẩm</CardTitle></CardHeader>
                    <CardContent className="space-y-4">
                        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                            <div className="space-y-2">
                                <Label>Sản phẩm</Label>
                                <Select value={currentItem.productId} onValueChange={handleProductSelect}>
                                    <SelectTrigger><SelectValue placeholder="Chọn sản phẩm" /></SelectTrigger>
                                    <SelectContent className="bg-popover max-h-[200px]">
                                        {products.map(p => (
                                            <SelectItem key={p.id} value={String(p.id)}>{p.name}</SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                            <div className="space-y-2">
                                <Label>Giá bán</Label>
                                <Input type="number" value={currentItem.unitPrice} onChange={(e) => setCurrentItem({ ...currentItem, unitPrice: e.target.value })} placeholder="0" />
                            </div>
                            <div className="space-y-2">
                                <Label>Số lượng</Label>
                                <Input type="number" value={currentItem.quantity} onChange={(e) => setCurrentItem({ ...currentItem, quantity: e.target.value })} placeholder="0" />
                            </div>
                            <div className="flex items-end">
                                <Button onClick={addItem} className="w-full"><Plus className="h-4 w-4 mr-2" />Thêm</Button>
                            </div>
                        </div>

                        {items.length > 0 && (
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead>Sản phẩm</TableHead>
                                        <TableHead className="text-right">Giá bán</TableHead>
                                        <TableHead className="text-right">Số lượng</TableHead>
                                        <TableHead className="text-right">Thành tiền</TableHead>
                                        <TableHead className="w-10"></TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {items.map((item, index) => (
                                        <TableRow key={index}>
                                            <TableCell>{item.productName}</TableCell>
                                            <TableCell className="text-right">{formatCurrency(item.unitPrice)}</TableCell>
                                            <TableCell className="text-right">{item.quantity}</TableCell>
                                            <TableCell className="text-right">{formatCurrency(item.quantity * item.unitPrice)}</TableCell>
                                            <TableCell>
                                                <Button variant="ghost" size="icon" onClick={() => removeItem(index)}>
                                                    <Trash2 className="h-4 w-4 text-destructive" />
                                                </Button>
                                            </TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                                <TableFooter>
                                    <TableRow>
                                        <TableCell colSpan={3} className="text-right font-bold">Tổng cộng:</TableCell>
                                        <TableCell className="text-right font-bold">{formatCurrency(items.reduce((sum, item) => sum + item.quantity * item.unitPrice, 0))}</TableCell>
                                        <TableCell></TableCell>
                                    </TableRow>
                                </TableFooter>
                            </Table>
                        )}
                    </CardContent>
                </Card>

                <div className="flex justify-end gap-2">
                    <Button variant="outline" onClick={() => setIsCreating(false)}>Hủy</Button>
                    <Button onClick={handleSave} disabled={saving}>
                        {saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}
                        Lưu xuất kho
                    </Button>
                </div>
            </div>
        )
    }

    return (
        <div className="space-y-6 animate-fade-in">
            <Tabs value={viewMode} onValueChange={(v) => setViewMode(v as 'products' | 'entries')}>
                <div className="flex items-center justify-between gap-4 flex-wrap mb-4">
                    <TabsList>
                        <TabsTrigger value="products">Danh sách sản phẩm</TabsTrigger>
                        <TabsTrigger value="entries">Theo phiếu xuất</TabsTrigger>
                    </TabsList>
                    <div className="flex gap-2">
                        <Button variant="outline" onClick={handleExportExcel}><Download className="h-4 w-4 mr-2" />Xuất Excel</Button>
                        <Button onClick={() => setIsCreating(true)}><Plus className="h-4 w-4 mr-2" />Tạo xuất kho</Button>
                    </div>
                </div>

                {/* Filter Bar */}
                <Card className="border-border/50 mb-6">
                    <CardContent className="py-4">
                        <div className="flex flex-wrap items-end gap-4">
                            <div className="space-y-1 min-w-[180px]">
                                <Label className="text-xs text-muted-foreground">Sản phẩm</Label>
                                <Select value={filterProduct} onValueChange={setFilterProduct}>
                                    <SelectTrigger><SelectValue /></SelectTrigger>
                                    <SelectContent className="bg-popover max-h-[200px]">
                                        <SelectItem value="all">Tất cả sản phẩm</SelectItem>
                                        {products.map(p => (
                                            <SelectItem key={p.id} value={String(p.id)}>{p.name}</SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                            <div className="space-y-1 min-w-[150px]">
                                <Label className="text-xs text-muted-foreground">Kho</Label>
                                <Select value={filterWarehouse} onValueChange={setFilterWarehouse}>
                                    <SelectTrigger><SelectValue /></SelectTrigger>
                                    <SelectContent className="bg-popover">
                                        <SelectItem value="all">Tất cả kho</SelectItem>
                                        {warehouses.map(w => (
                                            <SelectItem key={w.id} value={String(w.id)}>{w.name}</SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                            <div className="space-y-1 flex-1 min-w-[200px]">
                                <Label className="text-xs text-muted-foreground">Tìm kiếm</Label>
                                <div className="relative">
                                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                                    <Input placeholder="Tìm kiếm..." value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
                                </div>
                            </div>
                            {hasActiveFilters && (
                                <Button variant="ghost" size="sm" onClick={clearFilters} className="h-10">
                                    <X className="h-4 w-4 mr-1" />Xóa lọc
                                </Button>
                            )}
                        </div>
                    </CardContent>
                </Card>

                <TabsContent value="products" className="mt-0">
                    <Card className="border-border/50">
                        <CardHeader className="pb-3"><CardTitle>Xuất kho ({filteredExports.length} sản phẩm)</CardTitle></CardHeader>
                        <CardContent className="p-0">
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead>ID</TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('product')}>
                                            <div className="flex items-center gap-1">Sản phẩm <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('warehouse')}>
                                            <div className="flex items-center gap-1">Kho <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead className="text-right">Số lượng</TableHead>
                                        <TableHead className="text-right">Đơn giá</TableHead>
                                        <TableHead className="text-right cursor-pointer" onClick={() => handleSort('amount')}>
                                            <div className="flex items-center justify-end gap-1">Thành tiền <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('date')}>
                                            <div className="flex items-center gap-1">Ngày xuất <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {filteredExports.length === 0 ? (
                                        <TableRow>
                                            <TableCell colSpan={7} className="text-center py-8 text-muted-foreground">
                                                Không có dữ liệu
                                            </TableCell>
                                        </TableRow>
                                    ) : (
                                        filteredExports.map((item) => (
                                            <TableRow key={item.id}>
                                                <TableCell className="font-medium">{item.id}</TableCell>
                                                <TableCell>{item.product?.name}</TableCell>
                                                <TableCell>{item.warehouse?.name}</TableCell>
                                                <TableCell className="text-right">{item.total?.toLocaleString()}</TableCell>
                                                <TableCell className="text-right">{formatCurrency(item.price)}</TableCell>
                                                <TableCell className="text-right">{formatCurrency(item.income)}</TableCell>
                                                <TableCell>{formatDate(item.reportDate)}</TableCell>
                                            </TableRow>
                                        ))
                                    )}
                                </TableBody>
                                <TableFooter>
                                    <TableRow>
                                        <TableCell colSpan={5} className="text-right font-bold">Tổng tiền xuất:</TableCell>
                                        <TableCell className="text-right font-bold text-primary">{formatCurrency(totalIncome)}</TableCell>
                                        <TableCell></TableCell>
                                    </TableRow>
                                </TableFooter>
                            </Table>
                        </CardContent>
                    </Card>
                </TabsContent>

                <TabsContent value="entries" className="mt-0">
                    <Card className="border-border/50">
                        <CardHeader className="pb-3"><CardTitle>Danh sách phiếu xuất ({filteredExports.length})</CardTitle></CardHeader>
                        <CardContent className="p-0">
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead>ID</TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('warehouse')}>
                                            <div className="flex items-center gap-1">Kho <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead>Sản phẩm</TableHead>
                                        <TableHead className="text-right cursor-pointer" onClick={() => handleSort('amount')}>
                                            <div className="flex items-center justify-end gap-1">Tổng tiền <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('date')}>
                                            <div className="flex items-center gap-1">Ngày xuất <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead>Ghi chú</TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {filteredExports.length === 0 ? (
                                        <TableRow>
                                            <TableCell colSpan={6} className="text-center py-8 text-muted-foreground">
                                                Không có dữ liệu
                                            </TableCell>
                                        </TableRow>
                                    ) : (
                                        filteredExports.map((entry) => (
                                            <TableRow key={entry.id}>
                                                <TableCell className="font-medium">{entry.id}</TableCell>
                                                <TableCell>{entry.warehouse?.name}</TableCell>
                                                <TableCell>{entry.product?.name}</TableCell>
                                                <TableCell className="text-right">{formatCurrency(entry.income)}</TableCell>
                                                <TableCell>{formatDate(entry.reportDate)}</TableCell>
                                                <TableCell>{entry.note || '-'}</TableCell>
                                            </TableRow>
                                        ))
                                    )}
                                </TableBody>
                                <TableFooter>
                                    <TableRow>
                                        <TableCell colSpan={3} className="text-right font-bold">Tổng tiền xuất:</TableCell>
                                        <TableCell className="text-right font-bold text-primary">{formatCurrency(totalIncome)}</TableCell>
                                        <TableCell colSpan={2}></TableCell>
                                    </TableRow>
                                </TableFooter>
                            </Table>
                        </CardContent>
                    </Card>
                </TabsContent>
            </Tabs>
        </div>
    )
}
