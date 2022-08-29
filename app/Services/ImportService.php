<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Import;
use App\Services\LogActivityService;
use Illuminate\Support\Str;
use DB;
use Exception;

class ImportService
{
    public static function getAllImport($search){
        try {
            $query = Import::with('product');
            if($search->warehouse_id){
                $query->where("warehouse_id", $search->warehouse_id);
            }

            if ($search->reportdate) {
                $time = explode(' - ', trim($search->reportdate), 2);
                if ($time[0] == $time[1]) {
                    $query->whereDate('report_date', date('Y-m-d', strtotime($time[0])));
                } else {
                    $query->whereDate('report_date', '>=', date('Y-m-d', strtotime($time[0])))
                          ->whereDate('report_date', '<=', date('Y-m-d', strtotime($time[1])));
                }
            }

            if((int)$search->pro_id !== 0){
                $query->where("pro_id", $search->pro_id);
            }

            if($search->order_by){
                $order = explode('|', trim($search->order_by), 2);
                $query->orderBy($order[0], $order[1]);
            }
            $imports = $query->get();
            return $imports;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllProduct-catch', $e->getMessage());
        }
    }

    // public static function getImportFollowDay($search){
    //     try {
    //         $imports = DB::table('imports')->select(DB::raw('SUM(total) AS total_import, pro_id, price AS price_import'))->where("warehouse_id", $search->warehouse_id)->whereDate('report_date', '<=', date('Y-m-d', strtotime($search->day)))->groupBy("pro_id", "price")->get();
    //         // $sql = Str::replaceArray('?', $imports->getBindings(), $imports->toSql()); 
    //         // dd($sql);
    //         return $imports;
    //     } catch (Exception $e) {
    //         LogActivityService::addToLog('getImportFollowDay-catch', $e->getMessage());
    //     }
    // }
}