<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\LogActivityService;
use App\Services\ProductService;
use App\Models\Price;

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
            $message = $e->getMessage();
            return view('404', compact('message'));
        }
    }

    public function getPrice(Request $request){
        $user       = Auth::user();
        $result = array('status' => true, 'message' => 'Success', 'price' => 0);
        try {
            if(Auth::check()){
                $inputs = [
                    "pro_id"        => (int)$request->pro_id,
                    "warehouse_id"  => (int)$request->warehouse_id,
                    "is_import"     => (int)$request->is_import
                ];
                $price = Price::select("price")->where("pro_id", $inputs['pro_id'])->where("warehouse_id", $inputs['warehouse_id'])->where('is_import', $inputs['is_import'])->first();
                $result['price'] = isset($price->price) ? $price->price : 0;
            }else{
                $result['status'] = false;
                $result['message'] = 'Bạn chưa đăng nhập!';
            }
            return response()->json($result, 200);
        } catch (Exception $e) {
            LogActivityService::addToLog('getPrice-catch', $e->getMessage());
            $result['status'] = false;
            $result['message'] = $e->getMessage();
            return response()->json($result, 200);
        } 
    }

    public function getInventory(Request $request){
        $user       = Auth::user();
        $result = array('status' => true, 'message' => 'Success');
        try {
            if(Auth::check()){
                $inputs = (object)[
                    "warehouse_id"  => (int)$request->warehouse_id
                ];
                $data = ProductService::getAllDebt($inputs);
                $result['data'] = $data;
            }else{
                $result['status'] = false;
                $result['message'] = 'Bạn chưa đăng nhập!';
            }
            return response()->json($result, 200);
        } catch (Exception $e) {
            LogActivityService::addToLog('getInventory-catch', $e->getMessage());
            $result['status'] = false;
            $result['message'] = $e->getMessage();
            return response()->json($result, 200);
        } 
    }
}