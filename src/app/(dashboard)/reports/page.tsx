'use client'

import { useState, useEffect } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Badge } from '@/components/ui/badge'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts'
import { Loader2 } from 'lucide-react'
import { formatCurrency } from '@/lib/utils'

interface MonthlyData {
    month: string
    revenue: number
    profit: number
    cost: number
}

interface InventoryData {
    warehouse: string
    quantity: number
}

export default function ReportsPage() {
    const [monthlyData, setMonthlyData] = useState<MonthlyData[]>([])
    const [inventoryData, setInventoryData] = useState<InventoryData[]>([])
    const [loading, setLoading] = useState(true)
    const [year, setYear] = useState(String(new Date().getFullYear()))

    useEffect(() => {
        setLoading(true)
        fetch(`/api/reports?year=${year}&type=inventory`)
            .then(res => res.json())
            .then(data => {
                setMonthlyData(data.monthlyData || [])
                setInventoryData(data.inventoryData || [])
            })
            .catch(console.error)
            .finally(() => setLoading(false))
    }, [year])

    // Calculate totals
    const totalRevenue = monthlyData.reduce((sum, m) => sum + m.revenue, 0)
    const totalProfit = monthlyData.reduce((sum, m) => sum + m.profit, 0)
    const totalInventory = inventoryData.reduce((sum, i) => sum + i.quantity, 0)

    if (loading) {
        return (
            <div className="flex justify-center py-20">
                <Loader2 className="h-10 w-10 animate-spin text-muted-foreground" />
            </div>
        )
    }

    return (
        <div className="space-y-6 animate-fade-in">
            {/* Summary Cards */}
            <div className="grid gap-4 md:grid-cols-3">
                <Card className="border-border/50">
                    <CardContent className="p-4">
                        <p className="text-sm text-muted-foreground">Tổng doanh thu ({year})</p>
                        <p className="text-2xl font-bold text-primary">{formatCurrency(totalRevenue)}</p>
                    </CardContent>
                </Card>
                <Card className="border-border/50">
                    <CardContent className="p-4">
                        <p className="text-sm text-muted-foreground">Tổng lợi nhuận ({year})</p>
                        <p className="text-2xl font-bold text-success">{formatCurrency(totalProfit)}</p>
                    </CardContent>
                </Card>
                <Card className="border-border/50">
                    <CardContent className="p-4">
                        <p className="text-sm text-muted-foreground">Tổng tồn kho</p>
                        <p className="text-2xl font-bold">{totalInventory.toLocaleString()} sản phẩm</p>
                    </CardContent>
                </Card>
            </div>

            <Tabs defaultValue="revenue">
                <div className="flex items-center justify-between mb-4">
                    <TabsList>
                        <TabsTrigger value="revenue">Doanh thu</TabsTrigger>
                        <TabsTrigger value="profit">Lợi nhuận</TabsTrigger>
                        <TabsTrigger value="inventory">Tồn kho</TabsTrigger>
                    </TabsList>
                    <Select value={year} onValueChange={setYear}>
                        <SelectTrigger className="w-32">
                            <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value={String(new Date().getFullYear())}>Năm {new Date().getFullYear()}</SelectItem>
                            <SelectItem value={String(new Date().getFullYear() - 1)}>Năm {new Date().getFullYear() - 1}</SelectItem>
                        </SelectContent>
                    </Select>
                </div>

                <TabsContent value="revenue" className="mt-0">
                    <Card className="border-border/50">
                        <CardHeader><CardTitle>Báo cáo doanh thu theo tháng</CardTitle></CardHeader>
                        <CardContent>
                            <div className="h-[400px]">
                                <ResponsiveContainer width="100%" height="100%">
                                    <BarChart data={monthlyData}>
                                        <CartesianGrid strokeDasharray="3 3" className="stroke-border" />
                                        <XAxis dataKey="month" className="text-xs fill-muted-foreground" />
                                        <YAxis
                                            tickFormatter={(v) => v >= 1e9 ? `${(v / 1e9).toFixed(1)}B` : v >= 1e6 ? `${(v / 1e6).toFixed(0)}M` : `${(v / 1e3).toFixed(0)}K`}
                                            className="text-xs fill-muted-foreground"
                                        />
                                        <Tooltip
                                            formatter={(v: number) => formatCurrency(v)}
                                            contentStyle={{
                                                backgroundColor: 'hsl(var(--card))',
                                                border: '1px solid hsl(var(--border))',
                                                borderRadius: '8px'
                                            }}
                                        />
                                        <Bar dataKey="revenue" fill="hsl(270, 70%, 55%)" radius={[4, 4, 0, 0]} name="Doanh thu" />
                                    </BarChart>
                                </ResponsiveContainer>
                            </div>
                        </CardContent>
                    </Card>
                </TabsContent>

                <TabsContent value="profit" className="mt-0">
                    <Card className="border-border/50">
                        <CardHeader><CardTitle>Báo cáo lợi nhuận theo tháng</CardTitle></CardHeader>
                        <CardContent>
                            <div className="h-[400px]">
                                <ResponsiveContainer width="100%" height="100%">
                                    <BarChart data={monthlyData}>
                                        <CartesianGrid strokeDasharray="3 3" className="stroke-border" />
                                        <XAxis dataKey="month" className="text-xs fill-muted-foreground" />
                                        <YAxis
                                            tickFormatter={(v) => v >= 1e9 ? `${(v / 1e9).toFixed(1)}B` : v >= 1e6 ? `${(v / 1e6).toFixed(0)}M` : `${(v / 1e3).toFixed(0)}K`}
                                            className="text-xs fill-muted-foreground"
                                        />
                                        <Tooltip
                                            formatter={(v: number) => formatCurrency(v)}
                                            contentStyle={{
                                                backgroundColor: 'hsl(var(--card))',
                                                border: '1px solid hsl(var(--border))',
                                                borderRadius: '8px'
                                            }}
                                        />
                                        <Bar dataKey="profit" fill="hsl(142, 70%, 45%)" radius={[4, 4, 0, 0]} name="Lợi nhuận" />
                                    </BarChart>
                                </ResponsiveContainer>
                            </div>
                        </CardContent>
                    </Card>
                </TabsContent>

                <TabsContent value="inventory" className="mt-0">
                    <Card className="border-border/50">
                        <CardHeader><CardTitle>Tồn kho theo kho</CardTitle></CardHeader>
                        <CardContent>
                            {inventoryData.length === 0 ? (
                                <p className="text-muted-foreground text-center py-8">Chưa có dữ liệu tồn kho</p>
                            ) : (
                                <div className="grid gap-4 md:grid-cols-3">
                                    {inventoryData.map((item, idx) => (
                                        <Card key={idx} className="border-border/50">
                                            <CardContent className="p-4">
                                                <h4 className="font-semibold">{item.warehouse}</h4>
                                                <div className="mt-3 flex justify-between items-center">
                                                    <span className="text-2xl font-bold">{item.quantity.toLocaleString()}</span>
                                                    <Badge variant="secondary">sản phẩm</Badge>
                                                </div>
                                            </CardContent>
                                        </Card>
                                    ))}
                                </div>
                            )}
                        </CardContent>
                    </Card>
                </TabsContent>
            </Tabs>
        </div>
    )
}
