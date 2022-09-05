<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\LogActivityService;
use App\Services\ProductService;
use App\Models\Price;
use Exception;

class ProductController extends Controller
{
    public function list(Request $request){
        try {
            if(Auth::check()){
                $user       = Auth::user();
                $search         = (object)[
                    'order_by'    => $request->get('order_by','id|desc'),
                    'pro_id'      => $request->get('pro_id', 0)
                ];
                $orders_by = [
                    ['id' => 'id|asc',        'name' => 'Ngày tạo tăng dần'],
                    ['id' => 'id|desc',       'name' => 'Ngày tạo giảm dần']
                ];
                $productSearch  = ProductService::getSearchProduct($user);
                $products       = ProductService::getAllProduct($search, $user);
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
        $result = array('status' => true, 'message' => 'Success', 'price' => 0);
        try {
            if(Auth::check()){
                $user       = Auth::user();
                $inputs = [
                    "pro_id"        => (int)$request->pro_id,
                    "warehouse_id"  => (int)$request->warehouse_id,
                    "im_export"     => $request->im_export
                ];
                $price = Price::select("price")->where("pro_id", $inputs['pro_id'])->where("warehouse_id", $inputs['warehouse_id'])->where('im_export', $inputs['im_export'])->where('campain_id',$user->campain_id)->first();
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
        $result = array('status' => true, 'message' => 'Success');
        try {
            if(Auth::check()){
                $user       = Auth::user();
                $inputs = (object)[
                    "warehouse_id"  => (int)$request->warehouse_id
                ];
                $data = ProductService::getAllDebt($inputs, $user);
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