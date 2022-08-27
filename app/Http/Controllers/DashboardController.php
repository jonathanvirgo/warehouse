<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\LogActivityService;
use App\Models\Product;
use App\Models\Price;

class DashboardController extends Controller
{
    public function index(Request $request){
        return view('dashboard');
    }

    public function test(Request $request){
        // $product = Product::all();
        // foreach($product as $item){
        //     $input = [
        //         "pro_id" => $item['id'],
        //         "warehouse_id" => 1,
        //         "is_import" => 1,
        //         "price" => $item['price_import']
        //     ];
        //     Price::create($input);
        // }
    }
}