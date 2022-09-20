<?php

namespace App\Exports;
use DB;

use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class DebtDayExport implements FromQuery, WithHeadings, WithMapping, ShouldAutoSize
{
    use Exportable;
    private $warehouse_id;
    private $day;

    public function __construct($warehouse_id, $report_date)
    {
        $this->warehouse_id     = (int)$warehouse_id;
        $this->day              = $report_date;
    }

    public function query()
    {
        $sql = "SELECT * FROM (SELECT import.pro_id,import.price,import.total_import,pay.total_pay FROM (SELECT SUM(total) AS total_import, pro_id, price FROM imports WHERE `warehouse_id` = ".$this->warehouse_id." AND DATE(`report_date`) <= '".date('Y-m-d', strtotime($this->day))."' GROUP BY pro_id, price) AS `import` LEFT JOIN (SELECT SUM(total) AS total_pay, pro_id, price FROM pay WHERE `warehouse_id` = ".$this->warehouse_id." AND DATE(`report_date`) <= '".date('Y-m-d', strtotime($this->day))."' GROUP BY pro_id, price) AS pay ON import.`pro_id` = pay.pro_id AND import.`price` = pay.price) AS `total` INNER JOIN products ON products.id = total.pro_id";
        $query = DB::query()->select($sql);
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
            'Ngày thanh toán'
        ];
    }

    /**
     * Mapping data
     *
     * @return array
     */
    public function map($pay): array
    {   
        if(isset($pay['is_summary']) && $pay['is_summary'] == true){
            return [null, 'Tổng Số', null, null, $pay['sum_value'], null, null];
        }else{
            return [
                $pay->id,
                $pay->name,
                $pay->total,
                $pay->price,
                $pay->total * $pay->price,
                $pay->note,
                $pay->report_date
            ];
        }
    }

    public function prepareRows($pays)
    {
        dd($pays);
        $sum = 0;
        foreach($pays as $pay) $sum += $pay->total * $pay->price;
        $pays[]=[
            'is_summary'=>true,
            'sum_value'=>$sum
        ];
        return $pays;
    }
}
