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
    public static function getAllProduct($search){
        try {
            $query = Product::with('brand');
            
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

    public static function getAllDebt($search){
        try {
            $products = Debt::where('warehouse_id', $search->warehouse_id)->where('total','>',0)->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllDebt-catch', $e->getMessage());
        }
    }

    public static function getSearchProduct(){
        try {
            $products = Product::with('brand')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProduct-catch', $e->getMessage());
        }
    }

    public static function getSearchProductDept($search){
        try {
            $products = Debt::select("pro_id")->where('warehouse_id', $search->warehouse_id)->distinct()->where('total','>',0)->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductPay-catch', $e->getMessage());
        }
    }

    public static function getSearchProductPay($search){
        try {
            $products = Pay::select("pro_id")->where('warehouse_id', $search->warehouse_id)->distinct()->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductPay-catch', $e->getMessage());
        }
    }

    public static function getSearchProductImport(){
        try {
            $products = Import::select("pro_id")->distinct()->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductImport-catch', $e->getMessage());
        }
    }

    public static function getSearchProductExport(){
        try {
            $products = Export::select("pro_id")->distinct()->with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProductImport-catch', $e->getMessage());
        }
    }
}