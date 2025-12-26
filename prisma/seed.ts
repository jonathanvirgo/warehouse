import { PrismaClient } from '@prisma/client'
import bcrypt from 'bcryptjs'
import * as fs from 'fs'
import * as path from 'path'

const prisma = new PrismaClient()

// Define types for JSON data
interface JsonTable {
    type: string
    name?: string
    database?: string
    data?: Record<string, string | null>[]
}

interface PriceRecord {
    id: string
    pro_id: string
    warehouse_id: string
    im_export: string // 'nhap' or 'xuat'
    price: string
    campain_id: string
    created_at: string
    updated_at: string
}

// Helper function to parse date string to Date object
function parseDate(dateStr: string | null): Date | null {
    if (!dateStr) return null
    const date = new Date(dateStr)
    return isNaN(date.getTime()) ? null : date
}

// Helper function to parse integer
function parseInt_(value: string | null | undefined): number | null {
    if (value === null || value === undefined || value === '') return null
    const num = parseInt(value, 10)
    return isNaN(num) ? null : num
}

async function main() {
    console.log('🚀 Starting database seed from JSON...')

    // Read JSON file
    const jsonPath = path.join(__dirname, 'lbsjazko_khodinhduong.json')
    console.log(`📖 Reading JSON file from: ${jsonPath}`)

    const jsonContent = fs.readFileSync(jsonPath, 'utf-8')
    const jsonData: JsonTable[] = JSON.parse(jsonContent)

    // Extract tables from JSON
    const tables: Record<string, Record<string, string | null>[]> = {}
    for (const item of jsonData) {
        if (item.type === 'table' && item.name && item.data) {
            tables[item.name] = item.data
            console.log(`  📋 Found table: ${item.name} with ${item.data.length} records`)
        }
    }

    // ===== 1. Seed Roles =====
    console.log('\n📝 Seeding Roles...')
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
    }
    console.log(`  ✅ Seeded ${roles.length} roles`)

    // ===== 2. Seed Campain =====
    console.log('\n📝 Seeding Campains...')
    const campainData = tables['campain'] || []
    for (const item of campainData) {
        await prisma.campain.upsert({
            where: { id: parseInt(item.id!, 10) },
            update: {
                name: item.name || 'Unknown',
            },
            create: {
                id: parseInt(item.id!, 10),
                name: item.name || 'Unknown',
            },
        })
    }
    console.log(`  ✅ Seeded ${campainData.length} campains`)

    // ===== 3. Seed Warehouses =====
    console.log('\n📝 Seeding Warehouses...')
    const warehouseData = tables['warehouse'] || []
    for (const item of warehouseData) {
        await prisma.warehouse.upsert({
            where: { id: parseInt(item.id!, 10) },
            update: {
                name: item.name || 'Unknown',
                campainId: parseInt_(item.campain_id) || 1,
            },
            create: {
                id: parseInt(item.id!, 10),
                name: item.name || 'Unknown',
                campainId: parseInt_(item.campain_id) || 1,
            },
        })
    }
    console.log(`  ✅ Seeded ${warehouseData.length} warehouses`)

    // ===== 4. Seed Brands =====
    console.log('\n📝 Seeding Brands...')
    const brandData = tables['brands'] || []
    for (const item of brandData) {
        await prisma.brand.upsert({
            where: { id: parseInt(item.id!, 10) },
            update: {
                name: item.name || 'Unknown',
                campainId: parseInt_(item.campain_id) || 1,
            },
            create: {
                id: parseInt(item.id!, 10),
                name: item.name || 'Unknown',
                campainId: parseInt_(item.campain_id) || 1,
            },
        })
    }
    console.log(`  ✅ Seeded ${brandData.length} brands`)

    // ===== 5. Build price lookup from price table =====
    console.log('\n📝 Building price lookup...')
    const priceData = (tables['price'] || []) as unknown as PriceRecord[]
    const priceMap: Record<string, { importPrice: number | null; exportPrice: number | null }> = {}

    for (const price of priceData) {
        const proId = price.pro_id
        if (!priceMap[proId]) {
            priceMap[proId] = { importPrice: null, exportPrice: null }
        }
        if (price.im_export === 'nhap') {
            priceMap[proId].importPrice = parseInt_(price.price)
        } else if (price.im_export === 'xuat') {
            priceMap[proId].exportPrice = parseInt_(price.price)
        }
    }
    console.log(`  ✅ Built price lookup for ${Object.keys(priceMap).length} products`)

    // ===== 6. Seed Products =====
    console.log('\n📝 Seeding Products...')
    const productData = tables['products'] || []
    for (const item of productData) {
        const proId = item.id!
        const prices = priceMap[proId] || { importPrice: null, exportPrice: null }

        await prisma.product.upsert({
            where: { id: parseInt(proId, 10) },
            update: {
                name: item.name || 'Unknown',
                brandId: parseInt_(item.brand_id),
                campainId: parseInt_(item.campain_id) || 1,
                image: item.image,
                defaultImportPrice: prices.importPrice,
                defaultExportPrice: prices.exportPrice,
            },
            create: {
                id: parseInt(proId, 10),
                name: item.name || 'Unknown',
                brandId: parseInt_(item.brand_id),
                campainId: parseInt_(item.campain_id) || 1,
                image: item.image,
                defaultImportPrice: prices.importPrice,
                defaultExportPrice: prices.exportPrice,
            },
        })
    }
    console.log(`  ✅ Seeded ${productData.length} products`)

    // ===== 7. Seed Users =====
    console.log('\n📝 Seeding Users...')
    const userData = tables['users'] || []
    const hashedPassword = await bcrypt.hash('password123', 10)

    for (const item of userData) {
        const roleId = parseInt_(item.role_id) || 3
        // Skip if role doesn't exist (role > 5)
        if (roleId > 5) continue

        await prisma.user.upsert({
            where: { id: parseInt(item.id!, 10) },
            update: {
                name: item.name || 'Unknown',
                email: item.email || `user${item.id}@example.com`,
                roleId: roleId,
                warehouseId: parseInt_(item.warehouse_id),
                campainId: parseInt_(item.campain_id),
                avatar: item.avatar,
            },
            create: {
                id: parseInt(item.id!, 10),
                name: item.name || 'Unknown',
                email: item.email || `user${item.id}@example.com`,
                password: hashedPassword, // Use new hashed password
                roleId: roleId,
                warehouseId: parseInt_(item.warehouse_id),
                campainId: parseInt_(item.campain_id),
                avatar: item.avatar,
            },
        })
    }
    console.log(`  ✅ Seeded ${userData.length} users`)

    // ===== 8. Seed Discounts =====
    console.log('\n📝 Seeding Discounts...')
    // Read discount.json file
    const discountJsonPath = path.join(__dirname, 'discount.json')
    let discountData: Record<string, string | null>[] = []

    if (fs.existsSync(discountJsonPath)) {
        const discountContent = fs.readFileSync(discountJsonPath, 'utf-8')
        const discountJson: JsonTable[] = JSON.parse(discountContent)
        for (const item of discountJson) {
            if (item.type === 'table' && item.name === 'discount' && item.data) {
                discountData = item.data
            }
        }
    }

    for (const item of discountData) {
        await prisma.discount.upsert({
            where: { id: parseInt(item.id!, 10) },
            update: {
                name: item.name || 'Unknown',
                discountPercent: item.discount_percent ? parseFloat(item.discount_percent) : null,
                discountNumber: parseInt_(item.discount_number),
                campainId: parseInt_(item.campain_id) || 1,
            },
            create: {
                id: parseInt(item.id!, 10),
                name: item.name || 'Unknown',
                discountPercent: item.discount_percent ? parseFloat(item.discount_percent) : null,
                discountNumber: parseInt_(item.discount_number),
                campainId: parseInt_(item.campain_id) || 1,
            },
        })
    }
    console.log(`  ✅ Seeded ${discountData.length} discounts`)

    // ===== 9. Seed Imports =====
    console.log('\n📝 Seeding Imports...')
    const importData = tables['imports'] || []
    let importCount = 0
    for (const item of importData) {
        const proId = parseInt_(item.pro_id)
        const warehouseId = parseInt_(item.warehouse_id) || 1
        const createdBy = parseInt_(item.created_by)

        // Skip if product doesn't exist
        if (proId) {
            const product = await prisma.product.findUnique({ where: { id: proId } })
            if (!product) continue
        }

        // Skip if user doesn't exist
        if (createdBy) {
            const user = await prisma.user.findUnique({ where: { id: createdBy } })
            if (!user) continue
        }

        try {
            await prisma.import.upsert({
                where: { id: parseInt(item.id!, 10) },
                update: {
                    proId: proId,
                    total: parseInt_(item.total),
                    price: parseInt_(item.price),
                    reportDate: parseDate(item.report_date),
                    note: item.note,
                    createdBy: createdBy,
                    brandId: parseInt_(item.brand_id),
                    warehouseId: warehouseId,
                    campainId: parseInt_(item.campain_id),
                },
                create: {
                    id: parseInt(item.id!, 10),
                    proId: proId,
                    total: parseInt_(item.total),
                    price: parseInt_(item.price),
                    reportDate: parseDate(item.report_date),
                    note: item.note,
                    createdBy: createdBy,
                    brandId: parseInt_(item.brand_id),
                    warehouseId: warehouseId,
                    campainId: parseInt_(item.campain_id),
                },
            })
            importCount++
        } catch (error) {
            console.log(`  ⚠️ Skipping import ${item.id}: ${error instanceof Error ? error.message : 'Unknown error'}`)
        }
    }
    console.log(`  ✅ Seeded ${importCount} imports`)

    // ===== 10. Seed Exports =====
    console.log('\n📝 Seeding Exports...')
    const exportData = tables['exports'] || []
    let exportCount = 0
    for (const item of exportData) {
        const proId = parseInt_(item.pro_id) || 0
        const warehouseId = parseInt_(item.warehouse_id) || 1
        const createdBy = parseInt_(item.created_by)

        // Skip if product doesn't exist
        const product = await prisma.product.findUnique({ where: { id: proId } })
        if (!product) {
            console.log(`  ⚠️ Skipping export ${item.id}: Product ${proId} not found`)
            continue
        }

        // Skip if user doesn't exist (and createdBy is not null)
        if (createdBy) {
            const user = await prisma.user.findUnique({ where: { id: createdBy } })
            if (!user) {
                console.log(`  ⚠️ Skipping export ${item.id}: User ${createdBy} not found`)
                continue
            }
        }

        try {
            await prisma.export.upsert({
                where: { id: parseInt(item.id!, 10) },
                update: {
                    proId: proId,
                    priceImport: parseInt_(item.price_import) || 0,
                    priceExport: parseInt_(item.price_export) || 0,
                    total: parseInt_(item.total) || 0,
                    income: parseInt_(item.income),
                    discount: parseInt_(item.discount),
                    brandId: parseInt_(item.brand_id),
                    warehouseId: warehouseId,
                    reportDate: parseDate(item.report_date),
                    note: item.note,
                    typeDiscount: parseInt_(item.type_discount),
                    discountNumber: parseInt_(item.discount_number),
                    ship: parseInt_(item.ship),
                    createdBy: createdBy,
                    campainId: parseInt_(item.campain_id),
                },
                create: {
                    id: parseInt(item.id!, 10),
                    proId: proId,
                    priceImport: parseInt_(item.price_import) || 0,
                    priceExport: parseInt_(item.price_export) || 0,
                    total: parseInt_(item.total) || 0,
                    income: parseInt_(item.income),
                    discount: parseInt_(item.discount),
                    brandId: parseInt_(item.brand_id),
                    warehouseId: warehouseId,
                    reportDate: parseDate(item.report_date),
                    note: item.note,
                    typeDiscount: parseInt_(item.type_discount),
                    discountNumber: parseInt_(item.discount_number),
                    ship: parseInt_(item.ship),
                    createdBy: createdBy,
                    campainId: parseInt_(item.campain_id),
                },
            })
            exportCount++
        } catch (error) {
            console.log(`  ⚠️ Skipping export ${item.id}: ${error instanceof Error ? error.message : 'Unknown error'}`)
        }
    }
    console.log(`  ✅ Seeded ${exportCount} exports`)

    // ===== 11. Seed Debts =====
    console.log('\n📝 Seeding Debts...')
    const debtData = tables['debts'] || []
    let debtCount = 0
    for (const item of debtData) {
        const proId = parseInt_(item.pro_id)
        const createdBy = parseInt_(item.created_by)

        // Skip if product doesn't exist
        if (proId) {
            const product = await prisma.product.findUnique({ where: { id: proId } })
            if (!product) continue
        }

        // Skip if user doesn't exist
        if (createdBy) {
            const user = await prisma.user.findUnique({ where: { id: createdBy } })
            if (!user) continue
        }

        try {
            await prisma.debt.upsert({
                where: { id: parseInt(item.id!, 10) },
                update: {
                    proId: proId,
                    price: parseInt_(item.price),
                    total: parseInt_(item.total),
                    reportDate: parseDate(item.report_date),
                    createdBy: createdBy,
                    brandId: parseInt_(item.brand_id),
                    warehouseId: parseInt_(item.warehouse_id),
                    campainId: parseInt_(item.campain_id),
                },
                create: {
                    id: parseInt(item.id!, 10),
                    proId: proId,
                    price: parseInt_(item.price),
                    total: parseInt_(item.total),
                    reportDate: parseDate(item.report_date),
                    createdBy: createdBy,
                    brandId: parseInt_(item.brand_id),
                    warehouseId: parseInt_(item.warehouse_id),
                    campainId: parseInt_(item.campain_id),
                },
            })
            debtCount++
        } catch (error) {
            console.log(`  ⚠️ Skipping debt ${item.id}: ${error instanceof Error ? error.message : 'Unknown error'}`)
        }
    }
    console.log(`  ✅ Seeded ${debtCount} debts`)

    // ===== 12. Seed Pays =====
    console.log('\n📝 Seeding Pays...')
    const payData = tables['pay'] || []
    let payCount = 0
    for (const item of payData) {
        const proId = parseInt_(item.pro_id)
        const warehouseId = parseInt_(item.warehouse_id) || 1
        const createdBy = parseInt_(item.created_by)

        // Skip if product doesn't exist
        if (proId) {
            const product = await prisma.product.findUnique({ where: { id: proId } })
            if (!product) continue
        }

        // Skip if user doesn't exist
        if (createdBy) {
            const user = await prisma.user.findUnique({ where: { id: createdBy } })
            if (!user) continue
        }

        try {
            await prisma.pay.upsert({
                where: { id: parseInt(item.id!, 10) },
                update: {
                    proId: proId,
                    total: parseInt_(item.total),
                    price: parseInt_(item.price),
                    reportDate: parseDate(item.report_date),
                    note: item.note,
                    createdBy: createdBy,
                    brandId: parseInt_(item.brand_id),
                    warehouseId: warehouseId,
                    campainId: parseInt_(item.campain_id),
                },
                create: {
                    id: parseInt(item.id!, 10),
                    proId: proId,
                    total: parseInt_(item.total),
                    price: parseInt_(item.price),
                    reportDate: parseDate(item.report_date),
                    note: item.note,
                    createdBy: createdBy,
                    brandId: parseInt_(item.brand_id),
                    warehouseId: warehouseId,
                    campainId: parseInt_(item.campain_id),
                },
            })
            payCount++
        } catch (error) {
            console.log(`  ⚠️ Skipping pay ${item.id}: ${error instanceof Error ? error.message : 'Unknown error'}`)
        }
    }
    console.log(`  ✅ Seeded ${payCount} pays`)

    console.log('\n🎉 Database seeding completed!')
    console.log('\n📊 Summary:')
    console.log(`  - Roles: ${roles.length}`)
    console.log(`  - Campains: ${campainData.length}`)
    console.log(`  - Warehouses: ${warehouseData.length}`)
    console.log(`  - Brands: ${brandData.length}`)
    console.log(`  - Products: ${productData.length}`)
    console.log(`  - Users: ${userData.length}`)
    console.log(`  - Imports: ${importCount}`)
    console.log(`  - Exports: ${exportCount}`)
    console.log(`  - Debts: ${debtCount}`)
    console.log(`  - Pays: ${payCount}`)
}

main()
    .catch((e) => {
        console.error('❌ Error during seeding:', e)
        process.exit(1)
    })
    .finally(async () => {
        await prisma.$disconnect()
    })
