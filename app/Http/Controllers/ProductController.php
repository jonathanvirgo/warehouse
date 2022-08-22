<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\LogActivityService;
use App\Services\ProductService;

class ProductController extends Controller
{
    public function list(Request $request){
        $user       = Auth::user();
        try {
            if(Auth::check()){
                $search         = (object)[
                    'order_by'    => $request->get('order_by','id|desc'),
                    'pro_id'      => $request->get('pro_id', 0)
                ];
                $orders_by = [
                    ['id' => 'id|asc',        'name' => 'Ngày tạo tăng dần'],
                    ['id' => 'id|desc',       'name' => 'Ngày tạo giảm dần'],
                    ['id' => 'price|asc',     'name' => 'Giá tăng dần'],
                    ['id' => 'price|desc',    'name' => 'Giá giảm dần'],
                    ['id' => 'total|asc',     'name' => 'Số lượng tăng dần'],
                    ['id' => 'total|desc',     'name' => 'Số lượng giảm dần']
                ];
                $productSearch  = ProductService::getSearchProduct();
                $products       = ProductService::getAllProduct($search);
                return view('table.product',compact(
                    'products',
                    'search',
                    'orders_by',
                    'productSearch'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('listProduct-catch', $e->getMessage());
            return $e->getMessage();
        }
    }
}