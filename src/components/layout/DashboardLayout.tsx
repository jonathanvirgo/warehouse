'use client'

import { useState, useEffect } from 'react'
import { usePathname } from 'next/navigation'
import { AppSidebar } from './AppSidebar'
import { AppHeader } from './AppHeader'
import { cn } from '@/lib/utils'
import { useIsMobile } from '@/hooks/use-mobile'

const pageTitles: Record<string, string> = {
    '/dashboard': 'Tổng quan',
    '/products': 'Quản lý sản phẩm',
    '/imports': 'Nhập kho',
    '/exports': 'Xuất kho',
    '/inventory': 'Tồn kho',
    '/debts': 'Công nợ & Thanh toán',
    '/reports': 'Báo cáo',
    '/settings': 'Cài đặt',
    '/profile': 'Hồ sơ cá nhân',
}

interface DashboardLayoutProps {
    children: React.ReactNode
}

export function DashboardLayout({ children }: DashboardLayoutProps) {
    const isMobile = useIsMobile()
    const [sidebarOpen, setSidebarOpen] = useState(true)
    const pathname = usePathname()

    // Auto-close sidebar on mobile
    useEffect(() => {
        if (isMobile) {
            setSidebarOpen(false)
        } else {
            setSidebarOpen(true)
        }
    }, [isMobile])

    // Close sidebar when navigating on mobile
    useEffect(() => {
        if (isMobile) {
            setSidebarOpen(false)
        }
    }, [pathname, isMobile])

    const pageTitle = pageTitles[pathname] || ''

    return (
        <div className="min-h-screen bg-background">
            {/* Mobile overlay */}
            {isMobile && sidebarOpen && (
                <div
                    className="fixed inset-0 z-30 bg-black/50"
                    onClick={() => setSidebarOpen(false)}
                />
            )}

            <AppSidebar
                collapsed={!sidebarOpen}
                onToggle={() => setSidebarOpen(!sidebarOpen)}
                isMobile={isMobile}
            />

            <div
                className={cn(
                    'min-h-screen transition-all duration-300',
                    isMobile ? 'ml-0' : (sidebarOpen ? 'ml-64' : 'ml-16')
                )}
            >
                <AppHeader
                    title={pageTitle}
                    onMenuClick={() => setSidebarOpen(!sidebarOpen)}
                    showMenuButton={isMobile}
                />
                <main className="p-4 md:p-6">
                    {children}
                </main>
            </div>
        </div>
    )
}
