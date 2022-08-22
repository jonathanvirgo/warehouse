<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Import;
use App\Services\LogActivityService;

class ImportService
{
    public static function getAllImport($search){
        try {
            $query = Import::with('product');
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

    public static function getSearchProduct(){
        try {
            $products = Import::select("pro_id")->distinct()->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductImport-catch', $e->getMessage());
        }
    }
}