<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Export;
use App\Services\LogActivityService;
use Exception;

class ExportService
{
    public static function getAllExport($search, $user){
        try {
            $query = Export::where('campain_id',$user->campain_id)->with('product');
            
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

            if($search->type_discount){
                $query->where("type_discount", $search->type_discount);
            }

            if($search->order_by){
                $order = explode('|', trim($search->order_by), 2);
                $query->orderBy($order[0], $order[1]);
            }
            $exports = $query->get();
            return $exports;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllProduct-catch', $e->getMessage());
        }
    }
}