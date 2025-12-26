// Mock data for Warehouse Management System

export interface Product {
  id: string;
  sku: string;
  name: string;
  brand: string;
  costPrice: number;
  sellPrice: number;
  unit: string;
  image?: string;
  createdAt: string;
}

export interface StockEntry {
  id: string;
  code: string;
  type: 'import' | 'export';
  warehouseId: string;
  warehouseName: string;
  supplier?: string;
  customer?: string;
  totalAmount: number;
  status: 'pending' | 'completed' | 'cancelled';
  isPaid: boolean;
  note?: string;
  createdAt: string;
  createdBy: string;
  items: StockEntryItem[];
}

export interface StockEntryItem {
  productId: string;
  productName: string;
  quantity: number;
  unitPrice: number;
  total: number;
}

export interface Warehouse {
  id: string;
  name: string;
  description: string;
}

export interface Debt {
  id: string;
  code: string;
  productId: string;
  productName: string;
  warehouseId: string;
  warehouseName: string;
  quantity: number;
  amount: number;
  isPaid: boolean;
  note?: string;
  createdAt: string;
}

export interface Payment {
  id: string;
  code: string;
  productId: string;
  productName: string;
  warehouseId: string;
  warehouseName: string;
  quantity: number;
  amount: number;
  note?: string;
  createdAt: string;
  createdBy: string;
}

export interface Campaign {
  id: string;
  name: string;
  description: string;
}

export interface Brand {
  id: string;
  name: string;
  logo?: string;
  description: string;
}

export interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'manager' | 'staff';
  avatar?: string;
  status: 'active' | 'inactive';
  createdAt: string;
}

export interface Activity {
  id: string;
  type: 'import' | 'export' | 'payment' | 'product' | 'user';
  description: string;
  user: string;
  createdAt: string;
}

// Mock Warehouses
export const mockWarehouses: Warehouse[] = [
  { id: '1', name: 'Kho Hà Nội', description: 'Kho chính tại Hà Nội, lưu trữ sản phẩm Apple và Samsung' },
  { id: '2', name: 'Kho TP.HCM', description: 'Kho lớn nhất miền Nam' },
  { id: '3', name: 'Kho Đà Nẵng', description: 'Kho phục vụ miền Trung' },
];

// Mock Products (general products, not tied to warehouse)
export const mockProducts: Product[] = [
  {
    id: '1',
    sku: 'SP001',
    name: 'iPhone 15 Pro Max 256GB',
    brand: 'Apple',
    costPrice: 28000000,
    sellPrice: 32000000,
    unit: 'Cái',
    createdAt: '2024-01-15',
  },
  {
    id: '2',
    sku: 'SP002',
    name: 'Samsung Galaxy S24 Ultra',
    brand: 'Samsung',
    costPrice: 25000000,
    sellPrice: 29000000,
    unit: 'Cái',
    createdAt: '2024-01-20',
  },
  {
    id: '3',
    sku: 'SP003',
    name: 'MacBook Pro 14" M3',
    brand: 'Apple',
    costPrice: 45000000,
    sellPrice: 52000000,
    unit: 'Cái',
    createdAt: '2024-02-01',
  },
  {
    id: '4',
    sku: 'SP004',
    name: 'AirPods Pro 2',
    brand: 'Apple',
    costPrice: 5500000,
    sellPrice: 6500000,
    unit: 'Cái',
    createdAt: '2024-02-10',
  },
  {
    id: '5',
    sku: 'SP005',
    name: 'Dell XPS 15',
    brand: 'Dell',
    costPrice: 38000000,
    sellPrice: 45000000,
    unit: 'Cái',
    createdAt: '2024-02-15',
  },
  {
    id: '6',
    sku: 'SP006',
    name: 'iPad Pro 12.9"',
    brand: 'Apple',
    costPrice: 28000000,
    sellPrice: 33000000,
    unit: 'Cái',
    createdAt: '2024-02-20',
  },
  {
    id: '7',
    sku: 'SP007',
    name: 'Samsung Galaxy Tab S9',
    brand: 'Samsung',
    costPrice: 18000000,
    sellPrice: 22000000,
    unit: 'Cái',
    createdAt: '2024-03-01',
  },
  {
    id: '8',
    sku: 'SP008',
    name: 'Sony WH-1000XM5',
    brand: 'Sony',
    costPrice: 7000000,
    sellPrice: 8500000,
    unit: 'Cái',
    createdAt: '2024-03-05',
  },
];

// Mock Stock Entries
export const mockStockEntries: StockEntry[] = [
  {
    id: '1',
    code: 'NK001',
    type: 'import',
    warehouseId: '1',
    warehouseName: 'Kho Hà Nội',
    supplier: 'Công ty Apple Việt Nam',
    totalAmount: 560000000,
    status: 'completed',
    isPaid: true,
    note: 'Nhập hàng định kỳ tháng 12',
    createdAt: '2024-12-20',
    createdBy: 'Nguyễn Văn A',
    items: [
      { productId: '1', productName: 'iPhone 15 Pro Max 256GB', quantity: 20, unitPrice: 28000000, total: 560000000 },
    ],
  },
  {
    id: '2',
    code: 'NK002',
    type: 'import',
    warehouseId: '2',
    warehouseName: 'Kho TP.HCM',
    supplier: 'Samsung Electronics',
    totalAmount: 250000000,
    status: 'completed',
    isPaid: false,
    note: 'Nhập hàng Samsung',
    createdAt: '2024-12-21',
    createdBy: 'Trần Thị B',
    items: [
      { productId: '2', productName: 'Samsung Galaxy S24 Ultra', quantity: 10, unitPrice: 25000000, total: 250000000 },
    ],
  },
  {
    id: '3',
    code: 'XK001',
    type: 'export',
    warehouseId: '1',
    warehouseName: 'Kho Hà Nội',
    customer: 'Cửa hàng Điện tử ABC',
    totalAmount: 160000000,
    status: 'completed',
    isPaid: true,
    createdAt: '2024-12-22',
    createdBy: 'Nguyễn Văn A',
    items: [
      { productId: '1', productName: 'iPhone 15 Pro Max 256GB', quantity: 5, unitPrice: 32000000, total: 160000000 },
    ],
  },
  {
    id: '4',
    code: 'XK002',
    type: 'export',
    warehouseId: '2',
    warehouseName: 'Kho TP.HCM',
    customer: 'Đại lý XYZ',
    totalAmount: 145000000,
    status: 'pending',
    isPaid: false,
    createdAt: '2024-12-23',
    createdBy: 'Trần Thị B',
    items: [
      { productId: '2', productName: 'Samsung Galaxy S24 Ultra', quantity: 5, unitPrice: 29000000, total: 145000000 },
    ],
  },
];

// Mock Debts (unpaid items)
export const mockDebts: Debt[] = [
  {
    id: '1',
    code: 'CN001',
    productId: '2',
    productName: 'Samsung Galaxy S24 Ultra',
    warehouseId: '2',
    warehouseName: 'Kho TP.HCM',
    quantity: 10,
    amount: 250000000,
    isPaid: false,
    note: 'Công nợ nhập hàng Samsung',
    createdAt: '2024-12-21',
  },
  {
    id: '2',
    code: 'CN002',
    productId: '1',
    productName: 'iPhone 15 Pro Max 256GB',
    warehouseId: '1',
    warehouseName: 'Kho Hà Nội',
    quantity: 5,
    amount: 160000000,
    isPaid: false,
    note: 'Công nợ xuất hàng cho ABC',
    createdAt: '2024-12-22',
  },
];

// Mock Payments (paid items)
export const mockPayments: Payment[] = [
  {
    id: '1',
    code: 'TT001',
    productId: '1',
    productName: 'iPhone 15 Pro Max 256GB',
    warehouseId: '1',
    warehouseName: 'Kho Hà Nội',
    quantity: 20,
    amount: 560000000,
    note: 'Thanh toán nhập hàng Apple',
    createdAt: '2024-12-20',
    createdBy: 'Nguyễn Văn A',
  },
  {
    id: '2',
    code: 'TT002',
    productId: '1',
    productName: 'iPhone 15 Pro Max 256GB',
    warehouseId: '1',
    warehouseName: 'Kho Hà Nội',
    quantity: 5,
    amount: 160000000,
    note: 'Thanh toán xuất hàng',
    createdAt: '2024-12-22',
    createdBy: 'Trần Thị B',
  },
];

// Mock Campaigns
export const mockCampaigns: Campaign[] = [
  { id: '1', name: 'Khuyến mãi Tết 2025', description: 'Giảm giá 10% toàn bộ sản phẩm' },
  { id: '2', name: 'Black Friday', description: 'Giảm giá 20% sản phẩm Apple' },
  { id: '3', name: 'Mùa hè rực rỡ', description: 'Tặng phụ kiện khi mua điện thoại' },
];

// Mock Brands
export const mockBrands: Brand[] = [
  { id: '1', name: 'Apple', description: 'Thương hiệu công nghệ hàng đầu thế giới' },
  { id: '2', name: 'Samsung', description: 'Tập đoàn điện tử Hàn Quốc' },
  { id: '3', name: 'Dell', description: 'Hãng máy tính Mỹ' },
  { id: '4', name: 'Sony', description: 'Tập đoàn điện tử Nhật Bản' },
];

// Mock Users
export const mockUsers: User[] = [
  { id: '1', name: 'Admin', email: 'admin@warehouse.com', role: 'admin', status: 'active', createdAt: '2024-01-01' },
  { id: '2', name: 'Nguyễn Văn A', email: 'nguyenvana@warehouse.com', role: 'manager', status: 'active', createdAt: '2024-01-05' },
  { id: '3', name: 'Trần Thị B', email: 'tranthib@warehouse.com', role: 'manager', status: 'active', createdAt: '2024-01-10' },
  { id: '4', name: 'Lê Văn C', email: 'levanc@warehouse.com', role: 'staff', status: 'active', createdAt: '2024-02-01' },
  { id: '5', name: 'Phạm Thị D', email: 'phamthid@warehouse.com', role: 'staff', status: 'inactive', createdAt: '2024-02-15' },
];

// Mock Activities
export const mockActivities: Activity[] = [
  { id: '1', type: 'import', description: 'Nhập kho 20 iPhone 15 Pro Max', user: 'Nguyễn Văn A', createdAt: '2024-12-25T10:30:00' },
  { id: '2', type: 'export', description: 'Xuất kho 5 Samsung Galaxy S24 Ultra', user: 'Trần Thị B', createdAt: '2024-12-25T09:15:00' },
  { id: '3', type: 'payment', description: 'Thanh toán 80.000.000đ cho Cửa hàng ABC', user: 'Lê Văn C', createdAt: '2024-12-24T16:45:00' },
  { id: '4', type: 'product', description: 'Thêm sản phẩm mới: Sony WH-1000XM5', user: 'Nguyễn Văn A', createdAt: '2024-12-24T14:20:00' },
  { id: '5', type: 'user', description: 'Cập nhật quyền người dùng: Phạm Thị D', user: 'Admin', createdAt: '2024-12-23T11:00:00' },
];

// Dashboard Stats
export const mockDashboardStats = {
  totalRevenue: 1250000000,
  revenueChange: 12.5,
  totalProfit: 185000000,
  profitChange: 8.3,
  totalDebt: 225000000,
  debtChange: -5.2,
  lowStockCount: 3,
  lowStockChange: 2,
};

// Revenue Chart Data
export const mockRevenueData = [
  { month: 'T1', revenue: 850000000, profit: 120000000 },
  { month: 'T2', revenue: 920000000, profit: 135000000 },
  { month: 'T3', revenue: 780000000, profit: 98000000 },
  { month: 'T4', revenue: 1050000000, profit: 165000000 },
  { month: 'T5', revenue: 1120000000, profit: 178000000 },
  { month: 'T6', revenue: 980000000, profit: 145000000 },
  { month: 'T7', revenue: 1250000000, profit: 185000000 },
  { month: 'T8', revenue: 1180000000, profit: 172000000 },
  { month: 'T9', revenue: 1350000000, profit: 198000000 },
  { month: 'T10', revenue: 1420000000, profit: 215000000 },
  { month: 'T11', revenue: 1580000000, profit: 245000000 },
  { month: 'T12', revenue: 1250000000, profit: 185000000 },
];

// Helper functions
export const formatCurrency = (amount: number): string => {
  return new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND',
  }).format(amount);
};

export const formatDate = (dateString: string): string => {
  return new Date(dateString).toLocaleDateString('vi-VN');
};

export const formatDateTime = (dateString: string): string => {
  return new Date(dateString).toLocaleString('vi-VN');
};