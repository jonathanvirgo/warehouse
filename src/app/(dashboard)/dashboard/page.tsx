'use client'

import { useState, useEffect } from 'react'
import { TrendingUp, TrendingDown, CreditCard, AlertTriangle, Loader2 } from 'lucide-react'
import { StatsCard, RevenueChart, RecentActivities } from '@/components/dashboard'
import { formatCurrency } from '@/lib/utils'

interface DashboardData {
    stats: {
        totalRevenue: number
        totalProfit: number
        totalDebt: number
        lowStockCount: number
        revenueChange?: number
        profitChange?: number
        debtChange?: number
        lowStockChange?: number
    }
    recentImports: Array<{
        id: number
        product: { name: string }
        total: number
        createdAt: string
    }>
    recentExports: Array<{
        id: number
        product: { name: string }
        total: number
        income: number
        createdAt: string
    }>
}

export default function DashboardPage() {
    const [data, setData] = useState<DashboardData | null>(null)
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        fetch('/api/dashboard')
            .then(res => res.json())
            .then(setData)
            .catch(console.error)
            .finally(() => setLoading(false))
    }, [])

    if (loading) {
        return (
            <div className="flex justify-center py-20">
                <Loader2 className="h-10 w-10 animate-spin text-muted-foreground" />
            </div>
        )
    }

    const stats = data?.stats || {
        totalRevenue: 0,
        totalProfit: 0,
        totalDebt: 0,
        lowStockCount: 0,
        revenueChange: 0,
        profitChange: 0,
        debtChange: 0,
        lowStockChange: 0,
    }

    return (
        <div className="space-y-6 animate-fade-in">
            {/* Stats Grid */}
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                <StatsCard
                    title="Doanh thu tháng"
                    value={formatCurrency(stats.totalRevenue)}
                    change={stats.revenueChange}
                    icon={TrendingUp}
                    iconColor="text-green-500"
                    iconBgColor="bg-green-500/10"
                />
                <StatsCard
                    title="Lợi nhuận"
                    value={formatCurrency(stats.totalProfit)}
                    change={stats.profitChange}
                    icon={TrendingDown}
                    iconColor="text-primary"
                    iconBgColor="bg-primary/10"
                />
                <StatsCard
                    title="Công nợ"
                    value={formatCurrency(stats.totalDebt)}
                    change={stats.debtChange}
                    icon={CreditCard}
                    iconColor="text-orange-500"
                    iconBgColor="bg-orange-500/10"
                />
                <StatsCard
                    title="Tồn kho thấp"
                    value={`${stats.lowStockCount} sản phẩm`}
                    change={stats.lowStockChange}
                    changeLabel="sản phẩm mới"
                    icon={AlertTriangle}
                    iconColor="text-destructive"
                    iconBgColor="bg-destructive/10"
                />
            </div>

            {/* Charts & Activities */}
            <div className="grid gap-6 lg:grid-cols-3">
                <div className="lg:col-span-2">
                    <RevenueChart />
                </div>
                <div className="lg:col-span-1">
                    <RecentActivities />
                </div>
            </div>
        </div>
    )
}
