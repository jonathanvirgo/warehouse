import * as XLSX from 'xlsx'

export interface ExcelColumn {
    header: string
    key: string
    width?: number
}

export function exportToExcel<T extends Record<string, unknown>>(
    data: T[],
    columns: ExcelColumn[],
    filename: string
): Blob {
    // Convert data to array of arrays
    const headers = columns.map(col => col.header)
    const rows = data.map(item => columns.map(col => item[col.key] ?? ''))

    // Create worksheet
    const ws = XLSX.utils.aoa_to_sheet([headers, ...rows])

    // Set column widths
    ws['!cols'] = columns.map(col => ({ wch: col.width || 15 }))

    // Create workbook
    const wb = XLSX.utils.book_new()
    XLSX.utils.book_append_sheet(wb, ws, 'Sheet1')

    // Generate buffer
    const buffer = XLSX.write(wb, { bookType: 'xlsx', type: 'buffer' })

    return new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' })
}

// Helper function for client-side download
export function downloadExcel(blob: Blob, filename: string) {
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `${filename}.xlsx`
    document.body.appendChild(a)
    a.click()
    document.body.removeChild(a)
    URL.revokeObjectURL(url)
}

// Format data for different types
export function formatImportsForExcel(data: Array<{
    id: number
    product?: { name: string }
    total?: number
    price?: number
    warehouse?: { name: string }
    reportDate?: string
    note?: string
    user?: { name: string }
}>) {
    return data.map(item => ({
        id: item.id,
        product: item.product?.name || '',
        quantity: item.total || 0,
        price: item.price || 0,
        totalPrice: (item.total || 0) * (item.price || 0),
        warehouse: item.warehouse?.name || '',
        date: item.reportDate ? new Date(item.reportDate).toLocaleDateString('vi-VN') : '',
        note: item.note || '',
        createdBy: item.user?.name || '',
    }))
}

export function formatExportsForExcel(data: Array<{
    id: number
    product?: { name: string }
    total?: number
    priceExport?: number
    income?: number
    warehouse?: { name: string }
    reportDate?: string
    note?: string
    user?: { name: string }
}>) {
    return data.map(item => ({
        id: item.id,
        product: item.product?.name || '',
        quantity: item.total || 0,
        price: item.priceExport || 0,
        income: item.income || 0,
        warehouse: item.warehouse?.name || '',
        date: item.reportDate ? new Date(item.reportDate).toLocaleDateString('vi-VN') : '',
        note: item.note || '',
        createdBy: item.user?.name || '',
    }))
}

export function formatDebtsForExcel(data: Array<{
    id: number
    product?: { name: string }
    total?: number
    price?: number
    warehouse?: { name: string }
    reportDate?: string
    user?: { name: string }
}>) {
    return data.map(item => ({
        id: item.id,
        product: item.product?.name || '',
        quantity: item.total || 0,
        price: item.price || 0,
        totalPrice: (item.total || 0) * (item.price || 0),
        warehouse: item.warehouse?.name || '',
        date: item.reportDate ? new Date(item.reportDate).toLocaleDateString('vi-VN') : '',
        createdBy: item.user?.name || '',
    }))
}

export function formatPaysForExcel(data: Array<{
    id: number
    product?: { name: string }
    total?: number
    price?: number
    warehouse?: { name: string }
    reportDate?: string
    note?: string
    user?: { name: string }
}>) {
    return data.map(item => ({
        id: item.id,
        product: item.product?.name || '',
        quantity: item.total || 0,
        price: item.price || 0,
        totalPrice: (item.total || 0) * (item.price || 0),
        warehouse: item.warehouse?.name || '',
        date: item.reportDate ? new Date(item.reportDate).toLocaleDateString('vi-VN') : '',
        note: item.note || '',
        createdBy: item.user?.name || '',
    }))
}

// Column definitions
export const IMPORT_COLUMNS: ExcelColumn[] = [
    { header: 'ID', key: 'id', width: 8 },
    { header: 'Sản phẩm', key: 'product', width: 25 },
    { header: 'Số lượng', key: 'quantity', width: 12 },
    { header: 'Đơn giá', key: 'price', width: 15 },
    { header: 'Thành tiền', key: 'totalPrice', width: 15 },
    { header: 'Kho', key: 'warehouse', width: 15 },
    { header: 'Ngày', key: 'date', width: 12 },
    { header: 'Ghi chú', key: 'note', width: 20 },
    { header: 'Người tạo', key: 'createdBy', width: 15 },
]

export const EXPORT_COLUMNS: ExcelColumn[] = [
    { header: 'ID', key: 'id', width: 8 },
    { header: 'Sản phẩm', key: 'product', width: 25 },
    { header: 'Số lượng', key: 'quantity', width: 12 },
    { header: 'Đơn giá', key: 'price', width: 15 },
    { header: 'Doanh thu', key: 'income', width: 15 },
    { header: 'Kho', key: 'warehouse', width: 15 },
    { header: 'Ngày', key: 'date', width: 12 },
    { header: 'Ghi chú', key: 'note', width: 20 },
    { header: 'Người tạo', key: 'createdBy', width: 15 },
]

export const DEBT_COLUMNS: ExcelColumn[] = [
    { header: 'ID', key: 'id', width: 8 },
    { header: 'Sản phẩm', key: 'product', width: 25 },
    { header: 'Số lượng', key: 'quantity', width: 12 },
    { header: 'Đơn giá', key: 'price', width: 15 },
    { header: 'Thành tiền', key: 'totalPrice', width: 15 },
    { header: 'Kho', key: 'warehouse', width: 15 },
    { header: 'Ngày', key: 'date', width: 12 },
    { header: 'Người tạo', key: 'createdBy', width: 15 },
]

export const PAY_COLUMNS: ExcelColumn[] = [
    { header: 'ID', key: 'id', width: 8 },
    { header: 'Sản phẩm', key: 'product', width: 25 },
    { header: 'Số lượng', key: 'quantity', width: 12 },
    { header: 'Số tiền', key: 'price', width: 15 },
    { header: 'Tổng tiền', key: 'totalPrice', width: 15 },
    { header: 'Kho', key: 'warehouse', width: 15 },
    { header: 'Ngày', key: 'date', width: 12 },
    { header: 'Ghi chú', key: 'note', width: 20 },
    { header: 'Người tạo', key: 'createdBy', width: 15 },
]
