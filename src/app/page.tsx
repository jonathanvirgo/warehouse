import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { LandingHeader } from '@/components/layout/LandingHeader'
import {
  Package,
  BarChart3,
  Truck,
  Shield,
  Zap,
  Users,
  ArrowRight,
  CheckCircle2,
  Warehouse
} from 'lucide-react'

const features = [
  {
    icon: Package,
    title: 'Quản lý Sản phẩm',
    description: 'Theo dõi và quản lý toàn bộ danh mục sản phẩm với thông tin chi tiết.'
  },
  {
    icon: Truck,
    title: 'Nhập/Xuất Kho',
    description: 'Quản lý quy trình nhập xuất kho một cách hiệu quả và chính xác.'
  },
  {
    icon: BarChart3,
    title: 'Báo cáo Chi tiết',
    description: 'Phân tích dữ liệu với biểu đồ trực quan và báo cáo tùy chỉnh.'
  },
  {
    icon: Shield,
    title: 'Bảo mật Cao',
    description: 'Hệ thống phân quyền chi tiết, bảo vệ dữ liệu doanh nghiệp.'
  },
  {
    icon: Zap,
    title: 'Hiệu suất Nhanh',
    description: 'Giao diện mượt mà, xử lý nhanh chóng mọi thao tác.'
  },
  {
    icon: Users,
    title: 'Đa Người dùng',
    description: 'Hỗ trợ nhiều người dùng với vai trò và quyền hạn khác nhau.'
  }
]

const stats = [
  { value: '10K+', label: 'Sản phẩm' },
  { value: '500+', label: 'Doanh nghiệp' },
  { value: '99.9%', label: 'Uptime' },
  { value: '24/7', label: 'Hỗ trợ' }
]

const benefits = [
  'Quản lý tồn kho thời gian thực',
  'Tự động cảnh báo hàng tồn thấp',
  'Theo dõi công nợ và thanh toán',
  'Báo cáo doanh thu và lợi nhuận',
  'Hỗ trợ nhiều kho hàng',
  'Giao diện tiếng Việt thân thiện'
]

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <LandingHeader />

      {/* Hero Section */}
      <section className="py-20 lg:py-32 relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-primary/5 via-transparent to-primary/10" />
        <div className="absolute top-20 left-10 w-72 h-72 bg-primary/20 rounded-full blur-3xl" />
        <div className="absolute bottom-20 right-10 w-96 h-96 bg-primary/10 rounded-full blur-3xl" />

        <div className="container mx-auto px-4 relative z-10">
          <div className="max-w-4xl mx-auto text-center">
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary/10 text-primary text-sm font-medium mb-6">
              <Zap className="w-4 h-4" />
              Giải pháp quản lý kho hàng hiện đại
            </div>

            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold text-foreground mb-6 leading-tight">
              Quản lý Kho Hàng
              <span className="block text-primary mt-2">Thông Minh & Hiệu Quả</span>
            </h1>

            <p className="text-lg md:text-xl text-muted-foreground mb-8 max-w-2xl mx-auto">
              Hệ thống quản lý kho toàn diện giúp doanh nghiệp theo dõi hàng hóa,
              tối ưu vận hành và tăng trưởng bền vững.
            </p>

            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button size="lg" className="text-lg px-8" asChild>
                <Link href="/register">
                  Bắt đầu miễn phí
                  <ArrowRight className="w-5 h-5 ml-2" />
                </Link>
              </Button>
              <Button size="lg" variant="outline" className="text-lg px-8" asChild>
                <Link href="/dashboard">Xem Demo</Link>
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Stats */}
      <section className="py-12 border-y border-border/40 bg-muted/30">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            {stats.map((stat, index) => (
              <div key={index} className="text-center">
                <div className="text-3xl md:text-4xl font-bold text-primary mb-1">
                  {stat.value}
                </div>
                <div className="text-muted-foreground">{stat.label}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Features */}
      <section className="py-20 lg:py-28">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-4">
              Tính năng Nổi bật
            </h2>
            <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
              Đầy đủ công cụ bạn cần để quản lý kho hàng một cách chuyên nghiệp
            </p>
          </div>

          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {features.map((feature, index) => (
              <Card key={index} className="group hover:shadow-lg hover:shadow-primary/5 transition-all duration-300 hover:-translate-y-1 border-border/50">
                <CardContent className="p-6">
                  <div className="w-12 h-12 rounded-xl bg-primary/10 flex items-center justify-center mb-4 group-hover:bg-primary/20 transition-colors">
                    <feature.icon className="w-6 h-6 text-primary" />
                  </div>
                  <h3 className="text-xl font-semibold text-foreground mb-2">
                    {feature.title}
                  </h3>
                  <p className="text-muted-foreground">
                    {feature.description}
                  </p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Benefits */}
      <section className="py-20 lg:py-28 bg-muted/30">
        <div className="container mx-auto px-4">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div>
              <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-6">
                Tại sao chọn <span className="text-primary">KhoViet</span>?
              </h2>
              <p className="text-lg text-muted-foreground mb-8">
                Chúng tôi cung cấp giải pháp quản lý kho toàn diện, giúp bạn tiết kiệm
                thời gian và tối ưu hóa quy trình kinh doanh.
              </p>

              <div className="grid sm:grid-cols-2 gap-4">
                {benefits.map((benefit, index) => (
                  <div key={index} className="flex items-center gap-3">
                    <CheckCircle2 className="w-5 h-5 text-primary flex-shrink-0" />
                    <span className="text-foreground">{benefit}</span>
                  </div>
                ))}
              </div>
            </div>

            <div className="relative">
              <div className="absolute inset-0 bg-gradient-to-br from-primary/20 to-primary/5 rounded-3xl blur-2xl" />
              <Card className="relative border-border/50 shadow-xl">
                <CardContent className="p-8">
                  <div className="flex items-center gap-4 mb-6">
                    <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-primary to-primary/60 flex items-center justify-center">
                      <Warehouse className="w-8 h-8 text-primary-foreground" />
                    </div>
                    <div>
                      <h3 className="text-xl font-bold text-foreground">Dashboard</h3>
                      <p className="text-muted-foreground">Tổng quan hệ thống</p>
                    </div>
                  </div>

                  <div className="space-y-4">
                    <div className="flex justify-between items-center p-3 rounded-lg bg-muted/50">
                      <span className="text-foreground">Doanh thu tháng này</span>
                      <span className="font-bold text-primary">125.5M ₫</span>
                    </div>
                    <div className="flex justify-between items-center p-3 rounded-lg bg-muted/50">
                      <span className="text-foreground">Sản phẩm trong kho</span>
                      <span className="font-bold text-foreground">1,234</span>
                    </div>
                    <div className="flex justify-between items-center p-3 rounded-lg bg-muted/50">
                      <span className="text-foreground">Phiếu xuất hôm nay</span>
                      <span className="font-bold text-foreground">48</span>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-20 lg:py-28">
        <div className="container mx-auto px-4">
          <div className="max-w-4xl mx-auto text-center">
            <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-6">
              Sẵn sàng nâng cấp quản lý kho?
            </h2>
            <p className="text-lg text-muted-foreground mb-8">
              Đăng ký ngay hôm nay và trải nghiệm sự khác biệt
            </p>
            <Button size="lg" className="text-lg px-8" asChild>
              <Link href="/register">
                Đăng ký miễn phí ngay
                <ArrowRight className="w-5 h-5 ml-2" />
              </Link>
            </Button>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-8 border-t border-border/40 bg-muted/30">
        <div className="container mx-auto px-4">
          <div className="flex flex-col md:flex-row items-center justify-between gap-4">
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-primary to-primary/60 flex items-center justify-center">
                <Warehouse className="w-5 h-5 text-primary-foreground" />
              </div>
              <span className="font-semibold text-foreground">KhoViet</span>
            </div>
            <p className="text-muted-foreground text-sm">
              © 2024 KhoViet. Bản quyền thuộc về KhoViet.
            </p>
          </div>
        </div>
      </footer>
    </div>
  )
}
