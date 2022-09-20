<?php

namespace App\Exports;

use App\Models\Export;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Illuminate\Support\Facades\Auth;

class ExportExport implements FromQuery, WithHeadings, WithMapping, ShouldAutoSize
{
    use Exportable;
    private $warehouse_id;
    private $product_id;
    private $report_date;
    private $type_discount;

    public function __construct($warehouse_id, $product_id, $report_date, $type_discount)
    {
        $this->warehouse_id     = (int)$warehouse_id;
        $this->pro_id           = (int)$product_id;
        $this->report_date      = $report_date;
        $this->type_discount    = (int)$type_discount;
    }

    public function query()
    {
        $query = Export::query()->where("warehouse_id", $this->warehouse_id)->where("type_discount", $this->type_discount)->join('products', 'exports.pro_id', '=', 'products.id');
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
        if(in_array(Auth::user()->role_id,[1,2])){
            return [
                'Id',
                'Sản phẩm',
                'Số lượng',
                'Giá nhập',
                'Giá xuất',
                'Chiếu khấu',
                'Tổng chiếu khấu',
                'Doanh thu',
                'Tổng doanh thu',
                'Ghi chú',
                'Ngày nhập'
            ];
        }else{
            return [
                'Id',
                'Sản phẩm',
                'Số lượng',
                'Giá xuất',
                'Chiếu khấu',
                'Tổng chiếu khấu',
                'Ghi chú',
                'Ngày nhập'
            ];
        }
    }

    /**
     * Mapping data
     *
     * @return array
     */
    public function map($export): array
    {   if(in_array(Auth::user()->role_id,[1,2])){
            if(isset($export['is_summary']) && $export['is_summary'] == true){
                return [null, 'Tổng Số', null, null, null, null, $export['sumDiscount'], null, $export['sumIncome'], null, null];
            }else{
                return [
                    $export->id,
                    $export->name,
                    $export->total,
                    $export->price_import,
                    $export->price_export,
                    $export->discount,
                    $export->total * $export->discount,
                    $export->income,
                    $export->total * $export->income,
                    $export->note,
                    $export->report_date,
                ];
            }
        }else{
            if(isset($export['is_summary']) && $export['is_summary'] == true){
                return [null, 'Tổng Số', null, null, null, $export['sumDiscount'], null, null];
            }else{
                return [
                    $export->id,
                    $export->name,
                    $export->total,
                    $export->price_export,
                    $export->discount,
                    $export->total * $export->discount,
                    $export->note,
                    $export->report_date,
                ];
            }
        }
    }

    public function prepareRows($exports)
    {
        $sumDiscount    = 0;
        $sumIncome      = 0;
        foreach($exports as $export) {
            $sumDiscount += $export->total * $export->discount;
            $sumIncome +=  $export->total * $export->income;
        }
        $exports[]=[
            'is_summary'    =>true,
            'sumDiscount'   =>$sumDiscount,
            'sumIncome'     =>$sumIncome,
        ];
        
        return $exports;
    }
}
