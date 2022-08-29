<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\ProductService;
use App\Services\PayService;
use App\Services\LogActivityService;
use App\Services\ImportService;
use App\Models\Pay;
use App\Models\Debt;
use App\Models\Warehouse;
use App\Models\Product;
use Illuminate\Support\Str;
use Exception;
use DB;

class PayController extends Controller
{
    public function index(Request $request){
        try {
            if(Auth::check()){
                $search         = (object)[
                    'warehouse_id'  => $request->get('warehouse_id', 1)
                ];
                $products = ProductService::getAllDebt($search);
                $warehouses = Warehouse::all();
                $today      = date('d-m-Y', strtotime(Carbon::today()));
                return view('common.pay',compact(
                    'products',
                    'today',
                    'warehouses'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('indexPay-catch', $e->getMessage());
            $message = $e->getMessage();
            return view('404', compact('message'));
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
                            "warehouse_id"  => $item->warehouse_id,
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
                    'warehouse_id'  => $request->get('warehouse_id', 1)
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

                $products   = ProductService::getSearchProductPay($search);
                $pays       = PayService::getAllPay($search);
                $warehouses = Warehouse::all();
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
                    'totalPrice',
                    'warehouses'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('listPay-catch', $e->getMessage());
            $message = $e->getMessage();
            return view('404', compact('message'));
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
                    'order_by'      => $request->get('order_by','id|desc'),
                    'pro_id'        => $request->get('pro_id', 0),
                    'warehouse_id'  => $request->get('warehouse_id', 1)
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
                $products   = ProductService::getSearchProductDept($search);
                $depts      = PayService::getAllDept($search);
                $warehouses = Warehouse::all();
                $totalPrice = 0;
                foreach($depts as $item){
                    $totalPrice += $item['price'] * $item['total'];
                }
                return view('table.debt',compact(
                    'depts',
                    'search',
                    'products',
                    'orders_by',
                    'totalPrice',
                    'warehouses'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('listDept-catch', $e->getMessage());
            $message = $e->getMessage();
            return view('404', compact('message'));
        }
    }

    public function deptListDay(Request $request){
        $user       = Auth::user();
        try {
            if(Auth::check()){
                $search         = (object)[
                    'day'           => $request->get('day', date('d-m-Y', strtotime(Carbon::today()))),
                    'warehouse_id'  => $request->get('warehouse_id', 1)
                ];
                // $imports    = ImportService::getImportFollowDay($search);
                // $pays       = PayService::getPayFollowDay($search);

                $sql = "SELECT import.pro_id,import.price,import.total_import,pay.total_pay,(import.total_import - pay.total_pay) AS total FROM (SELECT SUM(total) AS total_import, pro_id, price FROM imports WHERE warehouse_id = ".$search->warehouse_id." AND DATE(report_date) <= '". date('Y-m-d', strtotime($search->day)) ."' GROUP BY pro_id, price) AS `import` LEFT JOIN (SELECT SUM(total) AS total_pay, pro_id, price FROM pay WHERE warehouse_id = ".$search->warehouse_id." AND DATE(report_date) <= '".date('Y-m-d', strtotime($search->day))."' GROUP BY pro_id, price) AS pay ON import.pro_id = pay.pro_id";
                $sql = "SELECT * FROM (SELECT import.pro_id,import.price,import.total_import,pay.total_pay FROM (SELECT SUM(total) AS total_import, pro_id, price FROM imports WHERE `warehouse_id` = ".$search->warehouse_id." AND DATE(`report_date`) <= '".date('Y-m-d', strtotime($search->day))."' GROUP BY pro_id, price) AS `import` LEFT JOIN (SELECT SUM(total) AS total_pay, pro_id, price FROM pay WHERE `warehouse_id` = ".$search->warehouse_id." AND DATE(`report_date`) <= '".date('Y-m-d', strtotime($search->day))."' GROUP BY pro_id, price) AS pay ON import.`pro_id` = pay.pro_id) AS `total` INNER JOIN products ON products.id = total.pro_id";
                $data = DB::select($sql);
                $warehouses = Warehouse::all();
                $totalImports   = 0;
                $totalPay       = 0;
                foreach($data as $item){
                    $totalImports += $item->price * $item->total_import;
                    $totalPay += $item->price * (empty($item->total_pay) ? 0 : $item->total_pay);
                }
                return view('table.debtDay',compact(
                    'search',
                    'totalPay',
                    'totalImports',
                    'warehouses',
                    'data'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('deptListDay-catch', $e->getMessage());
            $message = $e->getMessage();
            return view('404', compact('message'));
        }
    }
}