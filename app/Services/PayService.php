<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Pay;
use App\Models\Debt;
use App\Services\LogActivityService;
use App\Models\Import;
use Exception;
use DB;

class PayService
{
    public static function getAllPay($search, $user){
        try {
            $query = Pay::where('campain_id', $user->campain_id)->with('product');
            if ($search->reportdate) {
                $time = explode(' - ', trim($search->reportdate), 2);
                if ($time[0] == $time[1]) {
                    $query->whereDate('report_date', date('Y-m-d', strtotime($time[0])));
                } else {
                    $query->whereDate('report_date', '>=', date('Y-m-d', strtotime($time[0])))
                          ->whereDate('report_date', '<=', date('Y-m-d', strtotime($time[1])));
                }
            }

            if($search->warehouse_id){
                $query->where("warehouse_id", $search->warehouse_id);
            }

            if((int)$search->pro_id !== 0){
                $query->where("pro_id", $search->pro_id);
            }

            if($search->order_by){
                $order = explode('|', trim($search->order_by), 2);
                $query->orderBy($order[0], $order[1]);
            }
            $pays = $query->get();
            return $pays;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllPay-catch', $e->getMessage());
        }
    }

    public static function getAllDept($search, $user){
        try {
            $query = Debt::where('total','>',0)->where('campain_id',$user->campain_id)->with('product');

            if($search->warehouse_id){
                $query->where("warehouse_id", $search->warehouse_id);
            }

            if((int)$search->pro_id !== 0){
                $query->where("pro_id", $search->pro_id);
            }

            if($search->order_by){
                $order = explode('|', trim($search->order_by), 2);
                $query->orderBy($order[0], $order[1]);
            }

            $depts = $query->get();
            return $depts;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllDept-catch', $e->getMessage());
        }
    }

    // public static function getPayFollowDay($search){
    //     try {
    //         $pays = DB::table('pay')->select(DB::raw('SUM(total) AS total_pay, pro_id, price'))->where("warehouse_id", $search->warehouse_id)->whereDate('report_date', '<=', date('Y-m-d', strtotime($search->day)))->groupBy("pro_id", "price")->get();
    //         return $pays;
    //     } catch (Exception $e) {
    //         LogActivityService::addToLog('getAllDept-catch', $e->getMessage());
    //     }
    // }

}