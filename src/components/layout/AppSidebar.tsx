'use client'

import { useEffect, useState } from 'react'
import { NavLink } from '@/components/NavLink'
import { cn } from '@/lib/utils'
import {
  LayoutDashboard,
  Package,
  ArrowDownToLine,
  ArrowUpFromLine,
  CreditCard,
  BarChart3,
  Settings,
  ChevronLeft,
  LogOut,
  Warehouse,
  X,
  LucideIcon,
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { ScrollArea } from '@/components/ui/scroll-area'

interface AppSidebarProps {
  collapsed: boolean
  onToggle: () => void
  isMobile?: boolean
}

// Role IDs
const ROLES = {
  ADMIN: 1,
  USER: 2,
  GUEST: 3,
  KHO: 4,
  XUAT: 5,
}

interface MenuItem {
  title: string
  url: string
  icon: LucideIcon
  roles: number[] // Which roles can see this menu
}

const allMenuItems: MenuItem[] = [
  { title: 'Tổng quan', url: '/dashboard', icon: LayoutDashboard, roles: [ROLES.ADMIN, ROLES.USER, ROLES.KHO, ROLES.XUAT] },
  { title: 'Nhập kho', url: '/imports', icon: ArrowDownToLine, roles: [ROLES.ADMIN, ROLES.USER, ROLES.KHO] },
  { title: 'Công nợ', url: '/debts', icon: CreditCard, roles: [ROLES.ADMIN, ROLES.USER, ROLES.KHO] },
  { title: 'Xuất kho', url: '/exports', icon: ArrowUpFromLine, roles: [ROLES.ADMIN, ROLES.USER, ROLES.XUAT] },
  { title: 'Sản phẩm', url: '/products', icon: Package, roles: [ROLES.ADMIN, ROLES.USER] },
  { title: 'Báo cáo', url: '/reports', icon: BarChart3, roles: [ROLES.ADMIN, ROLES.USER] },
  { title: 'Cài đặt', url: '/settings', icon: Settings, roles: [ROLES.ADMIN, ROLES.USER] },
]

export function AppSidebar({ collapsed, onToggle, isMobile }: AppSidebarProps) {
  const [roleId, setRoleId] = useState<number>(ROLES.USER)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetch('/api/auth/me')
      .then(res => res.json())
      .then(data => {
        if (data.user?.roleId) {
          setRoleId(data.user.roleId)
        }
      })
      .catch(console.error)
      .finally(() => setLoading(false))
  }, [])

  // Filter menu items based on role
  const menuItems = allMenuItems.filter(item => item.roles.includes(roleId))

  // On mobile: show full sidebar when open, hide completely when closed
  if (isMobile && collapsed) {
    return null
  }

  return (
    <aside
      className={cn(
        'fixed left-0 top-0 z-40 h-screen bg-sidebar border-r border-sidebar-border transition-all duration-300',
        isMobile ? 'w-64' : (collapsed ? 'w-16' : 'w-64')
      )}
    >
      <div className="flex h-full flex-col">
        {/* Logo */}
        <div className="flex h-16 items-center justify-between px-4 border-b border-sidebar-border">
          <div className="flex items-center gap-2">
            <div className="h-8 w-8 rounded-lg bg-primary flex items-center justify-center">
              <Warehouse className="h-5 w-5 text-primary-foreground" />
            </div>
            {(!collapsed || isMobile) && (
              <span className="font-bold text-lg text-sidebar-foreground">KhoViet</span>
            )}
          </div>
          {isMobile && (
            <Button
              variant="ghost"
              size="icon"
              onClick={onToggle}
              className="text-sidebar-foreground hover:bg-sidebar-accent"
            >
              <X className="h-5 w-5" />
            </Button>
          )}
        </div>

        {/* Navigation */}
        <ScrollArea className="flex-1 px-3 py-4">
          <nav className="space-y-1">
            {menuItems.map((item) => (
              <NavLink
                key={item.url}
                to={item.url}
                className={cn(
                  'flex items-center gap-3 rounded-lg px-3 py-2.5 text-sidebar-foreground transition-all hover:bg-sidebar-accent hover:text-sidebar-accent-foreground',
                  !isMobile && collapsed && 'justify-center px-2'
                )}
                activeClassName="bg-sidebar-primary text-sidebar-primary-foreground hover:bg-sidebar-primary hover:text-sidebar-primary-foreground"
              >
                <item.icon className="h-5 w-5 flex-shrink-0" />
                {(!collapsed || isMobile) && <span className="text-sm font-medium">{item.title}</span>}
              </NavLink>
            ))}
          </nav>
        </ScrollArea>

        {/* Footer - only show on desktop */}
        {!isMobile && (
          <div className="border-t border-sidebar-border p-3">
            <div className={cn('flex gap-2', collapsed ? 'flex-col' : 'flex-row')}>
              <Button
                variant="ghost"
                size="sm"
                onClick={onToggle}
                className={cn(
                  'text-sidebar-foreground hover:bg-sidebar-accent',
                  collapsed ? 'w-full justify-center' : 'flex-1'
                )}
              >
                <ChevronLeft className={cn('h-4 w-4 transition-transform', collapsed && 'rotate-180')} />
                {!collapsed && <span className="ml-2">Thu gọn</span>}
              </Button>
              {!collapsed && (
                <Button
                  variant="ghost"
                  size="sm"
                  className="text-sidebar-foreground hover:bg-sidebar-accent"
                >
                  <LogOut className="h-4 w-4" />
                </Button>
              )}
            </div>
          </div>
        )}
      </div>
    </aside>
  )
}
