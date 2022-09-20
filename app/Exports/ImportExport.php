<?php

namespace App\Exports;

use App\Models\Import;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class ImportExport implements FromQuery, WithHeadings, WithMapping, ShouldAutoSize
{
    use Exportable;
    private $warehouse_id;
    private $product_id;
    private $report_date;

    public function __construct($warehouse_id, $product_id, $report_date)
    {
        $this->warehouse_id     = (int)$warehouse_id;
        $this->pro_id           = (int)$product_id;
        $this->report_date      = $report_date;
    }

    public function query()
    {
        $query = Import::query()->where("warehouse_id", $this->warehouse_id)->join('products', 'imports.pro_id', '=', 'products.id');
        if($this->pro_id !== 0){
            $query->where("pro_id", $this->pro_id);
        }
        if ($this->report_date) {
            $time = explode(' - ', trim($this->report_date), 2);
            
            if ($time[0] == $time[1]) {
                $query->whereDate('report_date', date('Y-m-d', strtotime($time[0])));
            } else {
                $query->whereDate('report_date', '>=', date('Y-m-d', strtotime($time[0])))
                      ->whereDate('report_date', '<=', date('Y-m-d', strtotime($time[1])));
            }
        }
        return $query;
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
            'Tổng Giá',
            'Ghi chú',
            'Ngày nhập'
        ];
    }

    /**
     * Mapping data
     *
     * @return array
     */
    public function map($import): array
    {   
        if(isset($import['is_summary']) && $import['is_summary'] == true){
            return [null, 'Tổng Số', null, null, $import['sum_value'], null, null];
        }else{
            return [
                $import->id,
                $import->name,
                $import->total,
                $import->price,
                $import->total * $import->price,
                $import->note,
                $import->report_date
            ];
        }
    }

    public function prepareRows($imports)
    {
        $sum = 0;
        foreach($imports as $import) $sum += $import->total * $import->price;
        $imports[]=[
            'is_summary'=>true,
            'sum_value'=>$sum
        ];
        return $imports;
    }
}
