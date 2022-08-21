<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Product;
use App\Models\Debt;

class ProductService
{
    public static function getAllProduct(){
        try {
            $products = Product::all();
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
}