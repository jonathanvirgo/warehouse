'use client'

import { useState, useEffect, useMemo, useCallback } from 'react'
import { Plus, ArrowUpDown, X, Search, Download, Loader2 } from 'lucide-react'
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
import { exportToExcel, downloadExcel, formatDebtsForExcel, formatPaysForExcel, DEBT_COLUMNS, PAY_COLUMNS } from '@/lib/excel'

interface Product {
    id: number
    name: string
}

interface Warehouse {
    id: number
    name: string
}

interface DebtRecord {
    id: number
    product: Product | null
    warehouse: Warehouse | null
    total: number
    price: number
    reportDate: string
}

interface PayRecord {
    id: number
    product: Product | null
    warehouse: Warehouse | null
    total: number
    price: number
    reportDate: string
    note: string | null
}

type SortField = 'date' | 'amount' | 'product' | 'warehouse'
type SortDirection = 'asc' | 'desc'

export default function DebtsPage() {
    const [debts, setDebts] = useState<DebtRecord[]>([])
    const [pays, setPays] = useState<PayRecord[]>([])
    const [products, setProducts] = useState<Product[]>([])
    const [warehouses, setWarehouses] = useState<Warehouse[]>([])
    const [loading, setLoading] = useState(true)

    const [search, setSearch] = useState('')
    const [filterProduct, setFilterProduct] = useState('all')
    const [filterWarehouse, setFilterWarehouse] = useState('all')
    const [sortField, setSortField] = useState<SortField>('date')
    const [sortDirection, setSortDirection] = useState<SortDirection>('desc')

    const [isCreatingPayment, setIsCreatingPayment] = useState(false)
    const [saving, setSaving] = useState(false)
    const [formData, setFormData] = useState({
        productId: '',
        warehouseId: '',
        quantity: '',
        amount: '',
        date: new Date().toISOString().split('T')[0],
        note: '',
    })

    useEffect(() => {
        Promise.all([
            fetch('/api/products?limit=100').then(r => r.json()),
            fetch('/api/warehouses').then(r => r.json()),
            fetch('/api/debts?limit=100').then(r => r.json()),
            fetch('/api/pays?limit=100').then(r => r.json()),
        ]).then(([productsData, warehousesData, debtsData, paysData]) => {
            setProducts(productsData.data || [])
            setWarehouses(warehousesData.data || [])
            setDebts(debtsData.data || [])
            setPays(paysData.data || [])
            setLoading(false)
        }).catch(err => {
            console.error(err)
            setLoading(false)
        })
    }, [])

    // Filtered and sorted debts
    const filteredDebts = useMemo(() => {
        let result = [...debts]

        if (filterProduct !== 'all') {
            result = result.filter(d => String(d.product?.id) === filterProduct)
        }
        if (filterWarehouse !== 'all') {
            result = result.filter(d => String(d.warehouse?.id) === filterWarehouse)
        }
        if (search) {
            result = result.filter(d =>
                d.product?.name?.toLowerCase().includes(search.toLowerCase())
            )
        }

        result.sort((a, b) => {
            let comparison = 0
            switch (sortField) {
                case 'date':
                    comparison = (a.reportDate || '').localeCompare(b.reportDate || '')
                    break
                case 'amount':
                    comparison = (a.total * a.price) - (b.total * b.price)
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
    }, [debts, filterProduct, filterWarehouse, search, sortField, sortDirection])

    // Filtered and sorted payments
    const filteredPayments = useMemo(() => {
        let result = [...pays]

        if (filterProduct !== 'all') {
            result = result.filter(p => String(p.product?.id) === filterProduct)
        }
        if (filterWarehouse !== 'all') {
            result = result.filter(p => String(p.warehouse?.id) === filterWarehouse)
        }
        if (search) {
            result = result.filter(p =>
                p.product?.name?.toLowerCase().includes(search.toLowerCase())
            )
        }

        result.sort((a, b) => {
            let comparison = 0
            switch (sortField) {
                case 'date':
                    comparison = (a.reportDate || '').localeCompare(b.reportDate || '')
                    break
                case 'amount':
                    comparison = (a.total * a.price) - (b.total * b.price)
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
    }, [pays, filterProduct, filterWarehouse, search, sortField, sortDirection])

    const totalDebtAmount = filteredDebts.reduce((sum, d) => sum + (d.total * d.price), 0)
    const totalPaymentAmount = filteredPayments.reduce((sum, p) => sum + (p.total * p.price), 0)

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

    const handleExportDebts = () => {
        if (filteredDebts.length === 0) {
            toast({ title: 'Lỗi', description: 'Không có dữ liệu để xuất', variant: 'destructive' })
            return
        }
        const formattedData = formatDebtsForExcel(filteredDebts as Parameters<typeof formatDebtsForExcel>[0])
        const blob = exportToExcel(formattedData, DEBT_COLUMNS, 'cong-no')
        downloadExcel(blob, `cong-no-${new Date().toISOString().split('T')[0]}`)
        toast({ title: 'Thành công', description: `Đã xuất ${filteredDebts.length} bản ghi` })
    }

    const handleExportPays = () => {
        if (filteredPayments.length === 0) {
            toast({ title: 'Lỗi', description: 'Không có dữ liệu để xuất', variant: 'destructive' })
            return
        }
        const formattedData = formatPaysForExcel(filteredPayments as Parameters<typeof formatPaysForExcel>[0])
        const blob = exportToExcel(formattedData, PAY_COLUMNS, 'thanh-toan')
        downloadExcel(blob, `thanh-toan-${new Date().toISOString().split('T')[0]}`)
        toast({ title: 'Thành công', description: `Đã xuất ${filteredPayments.length} bản ghi` })
    }

    const handleCreatePayment = async () => {
        if (!formData.quantity || !formData.amount) {
            toast({ title: 'Lỗi', description: 'Vui lòng điền đầy đủ thông tin', variant: 'destructive' })
            return
        }

        setSaving(true)
        try {
            const res = await fetch('/api/pays', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    proId: formData.productId || null,
                    warehouseId: formData.warehouseId || null,
                    total: formData.quantity,
                    price: formData.amount,
                    reportDate: new Date(formData.date).toISOString(),
                    note: formData.note,
                }),
            })
            if (!res.ok) throw new Error('Failed')

            // Refresh data
            const paysRes = await fetch('/api/pays?limit=100')
            const paysData = await paysRes.json()
            setPays(paysData.data || [])

            setIsCreatingPayment(false)
            setFormData({ productId: '', warehouseId: '', quantity: '', amount: '', date: new Date().toISOString().split('T')[0], note: '' })
            toast({ title: 'Thành công', description: 'Đã tạo thanh toán' })
        } catch {
            toast({ title: 'Lỗi', description: 'Không thể tạo thanh toán', variant: 'destructive' })
        } finally {
            setSaving(false)
        }
    }

    if (loading) {
        return (
            <div className="flex justify-center py-20">
                <Loader2 className="h-10 w-10 animate-spin text-muted-foreground" />
            </div>
        )
    }

    if (isCreatingPayment) {
        return (
            <div className="space-y-6 animate-fade-in">
                <div className="flex items-center justify-between">
                    <h2 className="text-2xl font-bold">Tạo thanh toán</h2>
                    <Button variant="outline" onClick={() => setIsCreatingPayment(false)}>Hủy</Button>
                </div>

                <Card className="border-border/50">
                    <CardHeader><CardTitle>Thông tin thanh toán</CardTitle></CardHeader>
                    <CardContent className="space-y-4">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div className="space-y-2">
                                <Label>Sản phẩm</Label>
                                <Select value={formData.productId} onValueChange={(v) => setFormData({ ...formData, productId: v })}>
                                    <SelectTrigger><SelectValue placeholder="Chọn sản phẩm" /></SelectTrigger>
                                    <SelectContent className="bg-popover max-h-[200px]">
                                        {products.map(p => (
                                            <SelectItem key={p.id} value={String(p.id)}>{p.name}</SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                            <div className="space-y-2">
                                <Label>Kho</Label>
                                <Select value={formData.warehouseId} onValueChange={(v) => setFormData({ ...formData, warehouseId: v })}>
                                    <SelectTrigger><SelectValue placeholder="Chọn kho" /></SelectTrigger>
                                    <SelectContent className="bg-popover">
                                        {warehouses.map(w => (
                                            <SelectItem key={w.id} value={String(w.id)}>{w.name}</SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                        </div>
                        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div className="space-y-2">
                                <Label>Số lượng *</Label>
                                <Input type="number" value={formData.quantity} onChange={(e) => setFormData({ ...formData, quantity: e.target.value })} placeholder="0" />
                            </div>
                            <div className="space-y-2">
                                <Label>Số tiền *</Label>
                                <Input type="number" value={formData.amount} onChange={(e) => setFormData({ ...formData, amount: e.target.value })} placeholder="0" />
                            </div>
                            <div className="space-y-2">
                                <Label>Ngày thanh toán</Label>
                                <Input type="date" value={formData.date} onChange={(e) => setFormData({ ...formData, date: e.target.value })} />
                            </div>
                        </div>
                        <div className="space-y-2">
                            <Label>Ghi chú</Label>
                            <Textarea value={formData.note} onChange={(e) => setFormData({ ...formData, note: e.target.value })} placeholder="Nhập ghi chú..." />
                        </div>
                    </CardContent>
                </Card>

                <div className="flex justify-end gap-2">
                    <Button variant="outline" onClick={() => setIsCreatingPayment(false)}>Hủy</Button>
                    <Button onClick={handleCreatePayment} disabled={saving}>
                        {saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}
                        Lưu thanh toán
                    </Button>
                </div>
            </div>
        )
    }

    return (
        <div className="space-y-6 animate-fade-in">
            <Tabs defaultValue="debts">
                <div className="flex items-center justify-between gap-4 flex-wrap mb-4">
                    <TabsList>
                        <TabsTrigger value="debts">Công nợ</TabsTrigger>
                        <TabsTrigger value="payments">Thanh toán</TabsTrigger>
                    </TabsList>
                    <div className="flex gap-2">
                        <Button variant="outline" onClick={handleExportDebts}><Download className="h-4 w-4 mr-2" />Xuất Excel</Button>
                        <Button onClick={() => setIsCreatingPayment(true)}><Plus className="h-4 w-4 mr-2" />Tạo thanh toán</Button>
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

                <TabsContent value="debts" className="mt-0">
                    <Card className="border-border/50">
                        <CardHeader className="pb-3"><CardTitle>Danh sách công nợ (Chưa thanh toán)</CardTitle></CardHeader>
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
                                        <TableHead className="text-right cursor-pointer" onClick={() => handleSort('amount')}>
                                            <div className="flex items-center justify-end gap-1">Số tiền <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('date')}>
                                            <div className="flex items-center gap-1">Ngày tạo <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {filteredDebts.length === 0 ? (
                                        <TableRow>
                                            <TableCell colSpan={6} className="text-center py-8 text-muted-foreground">
                                                Không có dữ liệu
                                            </TableCell>
                                        </TableRow>
                                    ) : (
                                        filteredDebts.map((d) => (
                                            <TableRow key={d.id}>
                                                <TableCell className="font-medium">{d.id}</TableCell>
                                                <TableCell>{d.product?.name || '-'}</TableCell>
                                                <TableCell>{d.warehouse?.name || '-'}</TableCell>
                                                <TableCell className="text-right">{d.total?.toLocaleString()}</TableCell>
                                                <TableCell className="text-right">{formatCurrency(d.total * d.price)}</TableCell>
                                                <TableCell>{formatDate(d.reportDate)}</TableCell>
                                            </TableRow>
                                        ))
                                    )}
                                </TableBody>
                                <TableFooter>
                                    <TableRow>
                                        <TableCell colSpan={4} className="text-right font-bold">Tổng công nợ:</TableCell>
                                        <TableCell className="text-right font-bold text-destructive">{formatCurrency(totalDebtAmount)}</TableCell>
                                        <TableCell></TableCell>
                                    </TableRow>
                                </TableFooter>
                            </Table>
                        </CardContent>
                    </Card>
                </TabsContent>

                <TabsContent value="payments" className="mt-0">
                    <Card className="border-border/50">
                        <CardHeader className="pb-3"><CardTitle>Lịch sử thanh toán</CardTitle></CardHeader>
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
                                        <TableHead className="text-right cursor-pointer" onClick={() => handleSort('amount')}>
                                            <div className="flex items-center justify-end gap-1">Số tiền <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead className="cursor-pointer" onClick={() => handleSort('date')}>
                                            <div className="flex items-center gap-1">Ngày thanh toán <ArrowUpDown className="h-3 w-3" /></div>
                                        </TableHead>
                                        <TableHead>Ghi chú</TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {filteredPayments.length === 0 ? (
                                        <TableRow>
                                            <TableCell colSpan={7} className="text-center py-8 text-muted-foreground">
                                                Không có dữ liệu
                                            </TableCell>
                                        </TableRow>
                                    ) : (
                                        filteredPayments.map((p) => (
                                            <TableRow key={p.id}>
                                                <TableCell className="font-medium">{p.id}</TableCell>
                                                <TableCell>{p.product?.name || '-'}</TableCell>
                                                <TableCell>{p.warehouse?.name || '-'}</TableCell>
                                                <TableCell className="text-right">{p.total?.toLocaleString()}</TableCell>
                                                <TableCell className="text-right">{formatCurrency(p.total * p.price)}</TableCell>
                                                <TableCell>{formatDate(p.reportDate)}</TableCell>
                                                <TableCell>{p.note || '-'}</TableCell>
                                            </TableRow>
                                        ))
                                    )}
                                </TableBody>
                                <TableFooter>
                                    <TableRow>
                                        <TableCell colSpan={4} className="text-right font-bold">Tổng thanh toán:</TableCell>
                                        <TableCell className="text-right font-bold text-primary">{formatCurrency(totalPaymentAmount)}</TableCell>
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
