import { PrismaClient } from '@prisma/client'
import bcrypt from 'bcryptjs'

const prisma = new PrismaClient()

async function main() {
    console.log('Seeding database...')

    // Seed Roles
    const roles = [
        { id: 1, name: 'admin', displayName: 'Quản trị viên', description: 'Toàn quyền hệ thống' },
        { id: 2, name: 'user', displayName: 'Nhân viên', description: 'Quản lý data theo chiến dịch, không quản lý Users/Campaigns' },
        { id: 3, name: 'guest', displayName: 'Khách', description: 'Mới đăng ký, chờ duyệt' },
        { id: 4, name: 'kho', displayName: 'Nhân viên Kho', description: 'Chỉ xem Nhập kho, Công nợ (read-only)' },
        { id: 5, name: 'xuat', displayName: 'Nhân viên Xuất', description: 'Chỉ xem Xuất kho (read-only)' },
    ]

    for (const role of roles) {
        await prisma.role.upsert({
            where: { id: role.id },
            update: { name: role.name, displayName: role.displayName, description: role.description },
            create: role,
        })
        console.log(`Role: ${role.displayName}`)
    }

    // Seed default Campain if not exists
    const defaultCampain = await prisma.campain.upsert({
        where: { id: 1 },
        update: {},
        create: { id: 1, name: 'Default Campaign' },
    })
    console.log(`Campaign: ${defaultCampain.name}`)

    // Seed Admin user
    const hashedPassword = await bcrypt.hash('admin123', 10)
    const adminUser = await prisma.user.upsert({
        where: { email: 'admin@example.com' },
        update: { roleId: 1 }, // Ensure admin role
        create: {
            name: 'Admin',
            email: 'admin@example.com',
            password: hashedPassword,
            roleId: 1, // Admin role
            campainId: 1,
        },
    })
    console.log(`Admin user: ${adminUser.email}`)

    console.log('Seeding completed!')
}

main()
    .catch((e) => {
        console.error(e)
        process.exit(1)
    })
    .finally(async () => {
        await prisma.$disconnect()
    })
