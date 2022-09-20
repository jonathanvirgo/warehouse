<?php

namespace App\Exports;

use App\Models\Debt;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class DebtExport implements FromQuery, WithHeadings, WithMapping, ShouldAutoSize
{
    use Exportable;
    private $warehouse_id;
    private $product_id;

    public function __construct($warehouse_id, $product_id)
    {
        $this->warehouse_id     = (int)$warehouse_id;
        $this->pro_id       = (int)$product_id;
    }

    public function query()
    {
        if($this->pro_id !== 0){
            return Debt::query()->where('total','>',0)->where("warehouse_id", $this->warehouse_id)->where("pro_id", $this->pro_id)->join('products', 'debts.pro_id', '=', 'products.id');
        }else{
            return Debt::query()->where('total','>',0)->where("warehouse_id", $this->warehouse_id)->with('product')->join('products', 'debts.pro_id', '=', 'products.id');
        }
        
    }
    /**
     * Set header columns
     *
     * @return array
     */
    public function headings(): array
    {
        return [
            'Id',
            'Sản phẩm',
            'Số lượng',
            'Đơn Giá',
            'Tổng Giá'
        ];
    }

    /**
     * Mapping data
     *
     * @return array
     */
    public function map($debt): array
    {
        return [
            $debt->id,
            $debt->name,
            $debt->total,
            $debt->price,
            $debt->total * $debt->price
        ];
    }
}
