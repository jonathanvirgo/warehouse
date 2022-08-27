<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\ProductService;
use App\Services\ImportService;
use App\Services\LogActivityService;
use App\Models\Import;
use App\Models\Debt;
use App\Models\Product;
use App\Models\Warehouse;

class ImportController extends Controller
{
    public function index(Request $request){
        $user       = Auth::user();
        try {
            if(Auth::check()){
                $products   = ProductService::getSearchProduct();
                $today      = date('d-m-Y', strtotime(Carbon::today()));
                $warehouses = Warehouse::all();
                return view('common.import',compact(
                    'products',
                    'today',
                    'warehouses'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('indexImport-catch', $e->getMessage());
            $message = $e->getMessage();
            return view('404', compact('message'));
        }
    }

    public function store(Request $request){
        $user   = Auth::user();
        $result = array('status' => true, 'message' => 'Lưu thành công', 'url' => '/import/list');

        try {
            if($request->has('arrImport') && Auth::check()){
                $arrImport = json_decode($request->arrImport);
                if(count($arrImport) > 0){
                    foreach($arrImport as $item){
                        $inputs = [
                            "pro_id"        => $item->pro_id,
                            "total"         => (int)$item->total,
                            "price"         => (int)$item->price,
                            "report_date"   => date('Y-m-d', strtotime($item->report_date)),
                            "note"          => $item->note,
                            "created_by"    => $user->id,
                            "warehouse_id"  => $item->warehouse_id
                        ];
                        Import::create($inputs);
                        if($item->paied == false){
                            $dept = Debt::where("pro_id", $item->pro_id)->where("price", (int)$item->price)->where("warehouse_id", $item->warehouse_id)->first();
                            if($dept){
                                $total = $dept->total + $inputs['total'];
                                $dept->update(["total" => $total, "type_id" => (int)$product->type_id]);
                            }else{
                                Debt::create($inputs);
                            }
                        }
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
            LogActivityService::addToLog('storeImport-catch', $e->getMessage());
            return response()->json($result, 200);
        }
    }

    public function list(Request $request){
        $user       = Auth::user();
        try {
            if(Auth::check()){
                $fromdate       = Carbon::now()->addDays(-30)->format('d-m-Y');
                $todate         = Carbon::now()->addDays(30)->format('d-m-Y');
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
                $products       = ProductService::getSearchProductImport();
                $imports        = ImportService::getAllImport($search);
                $warehouses     = Warehouse::all();
                $totalPrice     = 0;
                foreach($imports as $item){
                    $totalPrice += $item['price'] * $item['total'];
                }
                return view('table.import',compact(
                    'imports',
                    'todate',
                    'fromdate',
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
            LogActivityService::addToLog('listImport-catch', $e->getMessage());
            $message = $e->getMessage();
            return view('404', compact('message'));
        }
    }
}