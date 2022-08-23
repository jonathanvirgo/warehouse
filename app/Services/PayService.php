<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Pay;
use App\Models\Debt;
use App\Services\LogActivityService;

class PayService
{
    public static function getAllPay($search){
        try {
            $query = Pay::with('product');
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
            $pays = $query->get();
            return $pays;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllPay-catch', $e->getMessage());
        }
    }

    public static function getAllDept($search){
        try {
            $query = Debt::where('total','>',0)->with('product');
            // if ($search->reportdate) {
            //     $time = explode(' - ', trim($search->reportdate), 2);
            //     if ($time[0] == $time[1]) {
            //         $query->whereDate('report_date', date('Y-m-d', strtotime($time[0])));
            //     } else {
            //         $query->whereDate('report_date', '>=', date('Y-m-d', strtotime($time[0])))
            //               ->whereDate('report_date', '<=', date('Y-m-d', strtotime($time[1])));
            //     }
            // }

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

    public static function getSearchProductPay(){
        try {
            $products = Pay::select("pro_id")->distinct()->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductPay-catch', $e->getMessage());
        }
    }

    public static function getSearchProductDept(){
        try {
            $products = Debt::select("pro_id")->distinct()->where('total','>',0)->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductPay-catch', $e->getMessage());
        }
    }
}