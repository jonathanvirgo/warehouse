<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\ProductService;
use App\Services\PayService;
use App\Services\LogActivityService;
use App\Models\Pay;
use App\Models\Debt;
use App\Models\Product;

class PayController extends Controller
{
    public function index(Request $request){
        try {
            if(Auth::check()){
                $products = ProductService::getAllDebt();
                $today      = date('d-m-Y', strtotime(Carbon::today()));
                return view('common.pay',compact(
                    'products',
                    'today'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('indexPay-catch', $e->getMessage());
            return $e->getMessage();
        }
    }

    public function store(Request $request){
        $user   = Auth::user();
        $result = array('status' => true, 'message' => 'Lưu thành công', 'url' => '/pay/list');

        try {
            if($request->has('arrPay') && Auth::check()){
                $arrPay = json_decode($request->arrPay);
                if(count($arrPay) > 0){
                    foreach($arrPay as $item){
                        $inputs = [
                            "pro_id"        => $item->pro_id,
                            "total"         => (int)$item->total,
                            "price"         => (int)$item->price,
                            "report_date"   => date('Y-m-d', strtotime($item->report_date)),
                            "note"          => $item->note,
                            "created_by"    => $user->id
                        ];
                        if($item->id_debt > 0){
                            $dept = Debt::find($item->id_debt);
                            if($dept){
                                $total = $dept->total - $inputs['total'];
                                $dept->update(["total" => $total]);
                            }
                        }
                        Pay::create($inputs);
                    }
                }else{
                    $result['status']  = false;
                    $result['message'] = "Không có dữ liệu";
                }
            }else{
                $result['status']  = false;
                $result['message'] = "Không có dữ liệu";
            }
            return response()->json($result, 200);
        } catch (Exception $e) {
            $result['status']  = false;
            $result['message'] = $e->getMessage();
            LogActivityService::addToLog('storePay-catch', $e->getMessage());
            return response()->json($result, 200);
        }
    }

    public function list(Request $request){
        $user       = Auth::user();
        try {
            if(Auth::check()){
                $fromdate       = Carbon::now()->addDays(-30)->format('d-m-Y');
                $todate         = Carbon::now()->addDays(60)->format('d-m-Y');
                $search         = (object)[
                    'reportdate'  => $request->get('reportdate', $fromdate.' - '.$todate),
                    'order_by'    => $request->get('order_by','id|desc'),
                    'pro_id'      => $request->get('pro_id', 0),
                ];
                if ($search->reportdate) {
                    $time     = explode(' - ', trim($search->reportdate), 2);
                    $fromdate = date('d-m-Y', strtotime($time[0]));
                    $todate   = date('d-m-Y', strtotime($time[1]));
                }
                $orders_by = [
                    ['id' => 'id|asc',        'name' => 'Ngày tạo tăng dần'],
                    ['id' => 'id|desc',       'name' => 'Ngày tạo giảm dần'],
                    ['id' => 'price|asc',     'name' => 'Giá tăng dần'],
                    ['id' => 'price|desc',    'name' => 'Giá giảm dần'],
                    ['id' => 'total|asc',     'name' => 'Số lượng tăng dần'],
                    ['id' => 'total|desc',     'name' => 'Số lượng giảm dần'],
                    ['id' => 'report_date|asc', 'name' => 'Ngày nhập tăng dần'],
                    ['id' => 'report_date|desc', 'name' => 'Ngày nhập giảm dần'],
                ];

                $products   = PayService::getSearchProductPay();
                $pays       = PayService::getAllPay($search);
                $totalPrice = 0;
                foreach($pays as $item){
                    $totalPrice += $item['price'] * $item['total'];
                }
                return view('table.pay',compact(
                    'pays',
                    'fromdate',
                    'todate',
                    'search',
                    'orders_by',
                    'products',
                    'totalPrice'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('listPay-catch', $e->getMessage());
            return $e->getMessage();
        }
    }

    public function deptList(Request $request){
        $user       = Auth::user();
        try {
            if(Auth::check()){
                // $fromdate       = Carbon::now()->addDays(-30)->format('d-m-Y');
                // $todate         = Carbon::now()->addDays(30)->format('d-m-Y');
                $search         = (object)[
                    // 'reportdate'  => $request->get('reportdate', $fromdate.' - '.$todate),
                    'order_by'    => $request->get('order_by','id|desc'),
                    'pro_id'      => $request->get('pro_id', 0)
                ];
                // if ($search->reportdate) {
                //     $time     = explode(' - ', trim($search->reportdate), 2);
                //     $fromdate = date('d-m-Y', strtotime($time[0]));
                //     $todate   = date('d-m-Y', strtotime($time[1]));
                // }
                $orders_by = [
                    ['id' => 'id|asc',        'name' => 'Ngày tạo tăng dần'],
                    ['id' => 'id|desc',       'name' => 'Ngày tạo giảm dần'],
                    ['id' => 'price|asc',     'name' => 'Giá tăng dần'],
                    ['id' => 'price|desc',    'name' => 'Giá giảm dần'],
                    ['id' => 'total|asc',     'name' => 'Số lượng tăng dần'],
                    ['id' => 'total|desc',     'name' => 'Số lượng giảm dần'],
                    // ['id' => 'report_date|asc', 'name' => 'Ngày nhập tăng dần'],
                    // ['id' => 'report_date|desc', 'name' => 'Ngày nhập giảm dần'],
                ];
                $products   = PayService::getSearchProductDept();
                $depts      = PayService::getAllDept($search);
                $totalPrice = 0;
                foreach($depts as $item){
                    $totalPrice += $item['price'] * $item['total'];
                }
                return view('table.debt',compact(
                    'depts',
                    'search',
                    'products',
                    'orders_by',
                    'totalPrice'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('listDept-catch', $e->getMessage());
            return $e->getMessage();
        }
    }
}