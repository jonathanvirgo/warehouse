'use client'

import { useState, useEffect } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { ScrollArea } from '@/components/ui/scroll-area'
import { ArrowDownToLine, ArrowUpFromLine, CreditCard, Loader2 } from 'lucide-react'
import { cn } from '@/lib/utils'
import { formatCurrency, formatDate } from '@/lib/utils'

interface Activity {
  id: number
  type: 'import' | 'export' | 'payment'
  description: string
  user: string
  createdAt: string
}

const activityIcons = {
  import: ArrowDownToLine,
  export: ArrowUpFromLine,
  payment: CreditCard,
}

const activityColors = {
  import: 'text-info bg-info/10',
  export: 'text-warning bg-warning/10',
  payment: 'text-success bg-success/10',
}

export function RecentActivities() {
  const [activities, setActivities] = useState<Activity[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetch('/api/dashboard')
      .then(res => res.json())
      .then(data => {
        const recentImports = (data.recentImports || []).map((item: { id: number; product?: { name: string }; total?: number; price?: number; user?: { name: string }; createdAt?: string }) => ({
          id: item.id,
          type: 'import' as const,
          description: `Nhập ${item.product?.name || 'Sản phẩm'} - ${item.total || 0} x ${formatCurrency(item.price || 0)}`,
          user: item.user?.name || 'Hệ thống',
          createdAt: item.createdAt,
        }))

        const recentExports = (data.recentExports || []).map((item: { id: number; product?: { name: string }; total?: number; income?: number; user?: { name: string }; createdAt?: string }) => ({
          id: item.id + 10000,
          type: 'export' as const,
          description: `Xuất ${item.product?.name || 'Sản phẩm'} - ${formatCurrency(item.income || 0)}`,
          user: item.user?.name || 'Hệ thống',
          createdAt: item.createdAt,
        }))

        // Combine and sort by date
        const allActivities = [...recentImports, ...recentExports]
          .sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
          .slice(0, 10)

        setActivities(allActivities)
      })
      .catch(console.error)
      .finally(() => setLoading(false))
  }, [])

  if (loading) {
    return (
      <Card className="border-border/50">
        <CardHeader className="pb-3">
          <CardTitle className="text-lg font-semibold">Hoạt động gần đây</CardTitle>
        </CardHeader>
        <CardContent className="flex justify-center py-12">
          <Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
        </CardContent>
      </Card>
    )
  }

  return (
    <Card className="border-border/50">
      <CardHeader className="pb-3">
        <CardTitle className="text-lg font-semibold">Hoạt động gần đây</CardTitle>
      </CardHeader>
      <CardContent className="p-0">
        <ScrollArea className="h-[340px] px-6">
          <div className="space-y-4 pb-4">
            {activities.length === 0 ? (
              <div className="text-center py-8 text-muted-foreground">
                Chưa có hoạt động nào
              </div>
            ) : (
              activities.map((activity) => {
                const Icon = activityIcons[activity.type]
                const colorClass = activityColors[activity.type]

                return (
                  <div key={activity.id} className="flex items-start gap-4">
                    <div className={cn('p-2 rounded-lg flex-shrink-0', colorClass)}>
                      <Icon className="h-4 w-4" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium text-foreground leading-relaxed">
                        {activity.description}
                      </p>
                      <div className="flex items-center gap-2 mt-1">
                        <span className="text-xs text-muted-foreground">{activity.user}</span>
                        <span className="text-xs text-muted-foreground">•</span>
                        <span className="text-xs text-muted-foreground">
                          {formatDate(activity.createdAt)}
                        </span>
                      </div>
                    </div>
                  </div>
                )
              })
            )}
          </div>
        </ScrollArea>
      </CardContent>
    </Card>
  )
}
