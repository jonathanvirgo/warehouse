import { cookies } from 'next/headers'
import * as jose from 'jose'
import prisma from './prisma'

// Role IDs
export const ROLES = {
    ADMIN: 1,
    USER: 2,
    GUEST: 3,
    KHO: 4,
    XUAT: 5,
} as const

export type RoleId = (typeof ROLES)[keyof typeof ROLES]

// Role-based permissions
export const ROLE_PERMISSIONS = {
    [ROLES.ADMIN]: {
        canCreate: true,
        canEdit: true,
        canDelete: true,
        allowedRoutes: ['*'], // All routes
        canManageUsers: true,
        canManageCampaigns: true,
        filterByCampaign: false,
    },
    [ROLES.USER]: {
        canCreate: true,
        canEdit: true,
        canDelete: true,
        allowedRoutes: ['/dashboard', '/imports', '/exports', '/debts', '/products', '/reports', '/settings', '/profile'],
        canManageUsers: false,
        canManageCampaigns: false,
        filterByCampaign: true,
    },
    [ROLES.GUEST]: {
        canCreate: false,
        canEdit: false,
        canDelete: false,
        allowedRoutes: ['/pending-approval'],
        canManageUsers: false,
        canManageCampaigns: false,
        filterByCampaign: false,
    },
    [ROLES.KHO]: {
        canCreate: false,
        canEdit: false,
        canDelete: false,
        allowedRoutes: ['/dashboard', '/imports', '/debts', '/profile'],
        canManageUsers: false,
        canManageCampaigns: false,
        filterByCampaign: true,
    },
    [ROLES.XUAT]: {
        canCreate: false,
        canEdit: false,
        canDelete: false,
        allowedRoutes: ['/dashboard', '/exports', '/profile'],
        canManageUsers: false,
        canManageCampaigns: false,
        filterByCampaign: true,
    },
}

export interface AuthUser {
    id: number
    name: string
    email: string
    roleId: number
    roleName: string
    campainId: number | null
    warehouseId: number | null
}

// Get current user from JWT
export async function getCurrentUser(): Promise<AuthUser | null> {
    try {
        const cookieStore = await cookies()
        const token = cookieStore.get('token')?.value

        if (!token) return null

        const secret = new TextEncoder().encode(process.env.JWT_SECRET || 'fallback-secret')
        const { payload } = await jose.jwtVerify(token, secret)

        const userId = payload.userId as number
        const user = await prisma.user.findUnique({
            where: { id: userId },
            include: { role: true },
        })

        if (!user) return null

        return {
            id: user.id,
            name: user.name,
            email: user.email,
            roleId: user.roleId,
            roleName: user.role.name,
            campainId: user.campainId,
            warehouseId: user.warehouseId,
        }
    } catch {
        return null
    }
}

// Check if user can access a route
export function canAccessRoute(roleId: RoleId, route: string): boolean {
    const permissions = ROLE_PERMISSIONS[roleId]
    if (!permissions) return false

    if (permissions.allowedRoutes.includes('*')) return true
    return permissions.allowedRoutes.some(r => route.startsWith(r))
}

// Check if user can create/edit/delete
export function canCreate(roleId: RoleId): boolean {
    return ROLE_PERMISSIONS[roleId]?.canCreate || false
}

export function canEdit(roleId: RoleId): boolean {
    return ROLE_PERMISSIONS[roleId]?.canEdit || false
}

export function canDelete(roleId: RoleId): boolean {
    return ROLE_PERMISSIONS[roleId]?.canDelete || false
}

// Check user management permission
export function canManageUsers(roleId: RoleId): boolean {
    return ROLE_PERMISSIONS[roleId]?.canManageUsers || false
}

export function canManageCampaigns(roleId: RoleId): boolean {
    return ROLE_PERMISSIONS[roleId]?.canManageCampaigns || false
}

// Get campaign filter for queries
export function getCampaignFilter(user: AuthUser) {
    const permissions = ROLE_PERMISSIONS[user.roleId as RoleId]
    if (!permissions?.filterByCampaign) return {} // No filter for admin
    if (!user.campainId) return { campainId: -1 } // No campaign assigned = no data
    return { campainId: user.campainId }
}

// Get sidebar menu items based on role
export function getSidebarItems(roleId: RoleId) {
    const allItems = [
        { title: 'Dashboard', url: '/dashboard', icon: 'LayoutDashboard' },
        { title: 'Nhập kho', url: '/imports', icon: 'PackagePlus' },
        { title: 'Xuất kho', url: '/exports', icon: 'PackageMinus' },
        { title: 'Công nợ', url: '/debts', icon: 'CreditCard' },
        { title: 'Sản phẩm', url: '/products', icon: 'Package' },
        { title: 'Báo cáo', url: '/reports', icon: 'BarChart3' },
        { title: 'Cài đặt', url: '/settings', icon: 'Settings' },
    ]

    const permissions = ROLE_PERMISSIONS[roleId]
    if (!permissions) return []

    if (permissions.allowedRoutes.includes('*')) return allItems

    return allItems.filter(item =>
        permissions.allowedRoutes.some(route => item.url.startsWith(route))
    )
}
