<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Product;
use App\Models\Debt;
use App\Models\Pay;
use App\Models\Import;
use App\Models\Export;
use App\Services\LogActivityService;
use Exception;

class ProductService
{
    public static function getAllProduct($search, $user){
        try {
            $query = Product::where('campain_id', $user->campain_id)->with('brand');
            
            if((int)$search->pro_id !== 0){
                $query->where("id", $search->pro_id);
            }
            
            if($search->order_by){
                $order = explode('|', trim($search->order_by), 2);
                $query->orderBy($order[0], $order[1]);
            }
            $products = $query->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllProduct-catch', $e->getMessage());
        }
    }

    public static function getAllDebt($search, $user){
        try {
            $products = Debt::where('campain_id',$user->campain_id)->where('warehouse_id', $search->warehouse_id)->where('total','>',0)->with('product')->get();
            // dd($products);
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllDebt-catch', $e->getMessage());
        }
    }

    public static function getSearchProduct($user){
        try {
            $products = Product::where('campain_id',$user->campain_id)->with('brand')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProduct-catch', $e->getMessage());
        }
    }

    public static function getSearchProductDept($search, $user){
        try {
            $products = Debt::select("pro_id")->where('campain_id',$user->campain_id)->where('warehouse_id', $search->warehouse_id)->distinct()->where('total','>',0)->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductDept-catch', $e->getMessage());
        }
    }

    public static function getSearchProductPay($search, $user){
        try {
            $products = Pay::select("pro_id")->where('campain_id',$user->campain_id)->where('warehouse_id', $search->warehouse_id)->distinct()->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductPay-catch', $e->getMessage());
        }
    }

    public static function getSearchProductImport($user){
        try {
            $products = Import::select("pro_id")->where('campain_id',$user->campain_id)->distinct()->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductImport-catch', $e->getMessage());
        }
    }

    public static function getSearchProductExport($user){
        try {
            $products = Export::select("pro_id")->where('campain_id',$user->campain_id)->distinct()->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductImport-catch', $e->getMessage());
        }
    }
}