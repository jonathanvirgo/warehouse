import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { jwtVerify } from 'jose'

const JWT_SECRET = new TextEncoder().encode(
    process.env.JWT_SECRET || 'your-super-secret-key-change-in-production'
)

// Role IDs
const ROLES = {
    ADMIN: 1,
    USER: 2,
    GUEST: 3,
    KHO: 4,
    XUAT: 5,
}

// Routes that don't require authentication
const publicRoutes = ['/', '/login', '/register', '/pending-approval']

// Role-based route access
const roleRouteAccess: Record<number, string[]> = {
    [ROLES.ADMIN]: ['*'], // All routes
    [ROLES.USER]: ['/dashboard', '/imports', '/exports', '/debts', '/products', '/reports', '/settings', '/profile'],
    [ROLES.GUEST]: ['/pending-approval'], // Only pending approval page
    [ROLES.KHO]: ['/dashboard', '/imports', '/debts', '/profile'], // Only imports and debts
    [ROLES.XUAT]: ['/dashboard', '/exports', '/profile'], // Only exports
}

function canAccessRoute(roleId: number, pathname: string): boolean {
    const allowedRoutes = roleRouteAccess[roleId]
    if (!allowedRoutes) return false
    if (allowedRoutes.includes('*')) return true
    return allowedRoutes.some(route => pathname.startsWith(route))
}

function getRedirectForRole(roleId: number): string {
    switch (roleId) {
        case ROLES.GUEST:
            return '/pending-approval'
        case ROLES.KHO:
            return '/imports'
        case ROLES.XUAT:
            return '/exports'
        default:
            return '/dashboard'
    }
}

export async function middleware(request: NextRequest) {
    const { pathname } = request.nextUrl
    const token = request.cookies.get('auth_token')?.value

    const isPublicRoute = publicRoutes.includes(pathname)
    const isApiRoute = pathname.startsWith('/api')
    const isProtectedRoute = !isPublicRoute && !isApiRoute && !pathname.startsWith('/_next') && !pathname.startsWith('/favicon')

    // Skip middleware for API routes (they handle their own auth)
    if (isApiRoute) {
        return NextResponse.next()
    }

    // If no token and trying to access protected route
    if (isProtectedRoute && !token) {
        const loginUrl = new URL('/login', request.url)
        loginUrl.searchParams.set('redirect', pathname)
        return NextResponse.redirect(loginUrl)
    }

    // If has token, verify it and check role
    if (token) {
        try {
            const { payload } = await jwtVerify(token, JWT_SECRET)
            const roleId = (payload.roleId as number) || ROLES.GUEST

            // If logged in and trying to access login/register, redirect based on role
            if (pathname === '/login' || pathname === '/register') {
                return NextResponse.redirect(new URL(getRedirectForRole(roleId), request.url))
            }

            // Check role-based access for protected routes
            if (isProtectedRoute) {
                // Guest can only access pending-approval
                if (roleId === ROLES.GUEST && pathname !== '/pending-approval') {
                    return NextResponse.redirect(new URL('/pending-approval', request.url))
                }

                // Check if user can access this route
                if (!canAccessRoute(roleId, pathname)) {
                    return NextResponse.redirect(new URL(getRedirectForRole(roleId), request.url))
                }
            }

            // Allow access to pending-approval page redirection for non-guests
            if (pathname === '/pending-approval' && roleId !== ROLES.GUEST) {
                return NextResponse.redirect(new URL('/dashboard', request.url))
            }

        } catch {
            // Invalid token, clear it and redirect to login for protected routes
            if (isProtectedRoute) {
                const response = NextResponse.redirect(new URL('/login', request.url))
                response.cookies.delete('auth_token')
                return response
            }
        }
    }

    return NextResponse.next()
}

export const config = {
    matcher: [
        '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
    ],
}
