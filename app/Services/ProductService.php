<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Product;
use App\Models\Debt;
use App\Services\LogActivityService;

class ProductService
{
    public static function getAllProduct($search){
        try {
            $query = Product::with('type');
            
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

    public static function getAllDebt(){
        try {
            $products = Debt::with('product')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllDebt-catch', $e->getMessage());
        }
    }

    public static function getSearchProduct(){
        try {
            $products = Product::with('type')->get();
            return $products;
        } catch (Exception $e) {
            LogActivityService::addToLog('getSearchProduct-catch', $e->getMessage());
        }
    }
}