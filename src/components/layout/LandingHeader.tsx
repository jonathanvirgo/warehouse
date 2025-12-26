'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { Moon, Sun, Warehouse } from 'lucide-react'
import { useTheme } from 'next-themes'
import { Button } from '@/components/ui/button'

export function LandingHeader() {
    const { setTheme, resolvedTheme } = useTheme()
    const [mounted, setMounted] = useState(false)

    useEffect(() => {
        setMounted(true)
    }, [])

    const toggleTheme = () => {
        setTheme(resolvedTheme === 'dark' ? 'light' : 'dark')
    }

    return (
        <header className="border-b border-border/40 backdrop-blur-sm bg-background/80 sticky top-0 z-50">
            <div className="container mx-auto px-4 py-4 flex items-center justify-between">
                <div className="flex items-center gap-3">
                    <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-primary to-primary/60 flex items-center justify-center">
                        <Warehouse className="w-6 h-6 text-primary-foreground" />
                    </div>
                    <span className="text-xl font-bold text-foreground">KhoViet</span>
                </div>
                <div className="flex items-center gap-2">
                    {/* Theme Toggle */}
                    <Button variant="ghost" size="icon" onClick={toggleTheme}>
                        {mounted && resolvedTheme === 'dark' ? (
                            <Sun className="h-5 w-5" />
                        ) : (
                            <Moon className="h-5 w-5" />
                        )}
                    </Button>

                    <Button variant="ghost" asChild>
                        <Link href="/login">Đăng nhập</Link>
                    </Button>
                    <Button asChild>
                        <Link href="/register">Đăng ký miễn phí</Link>
                    </Button>
                </div>
            </div>
        </header>
    )
}
