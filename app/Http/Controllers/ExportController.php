<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\ExportService;
use App\Services\LogActivityService;
use App\Services\ProductService;
use App\Models\Warehouse;
use App\Models\Discount;
use App\Models\Export;
use Exception;

class ExportController extends Controller
{
    public function index(Request $request, $id = null){
        try {
            $export     = collect([]);
            $user = Auth::user();
            if(Auth::check() && in_array($user->role_id, [1,2])){
                $search         = (object)[
                    'warehouse_id'  => $request->get('warehouse_id', 1)
                ];
                $products   = ProductService::getSearchProduct($user);
                if(!empty($id)){
                    $export = Export::find($id);
                }
                $today      = date('d-m-Y', strtotime(Carbon::today()));
                $warehouses = Warehouse::where('campain_id',$user->campain_id)->get();
                $discounts = Discount::where('campain_id',$user->campain_id)->get();
                return view('common.export',compact(
                    'products',
                    'today',
                    'warehouses',
                    'discounts',
                    'export'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('indexExport-catch', $e->getMessage());
            return $e->getMessage();
        }
    }

    public function list(Request $request){
        try {
            $user           = Auth::user();
            if(Auth::check() && in_array($user->role_id, [1,2,5])){
                $fromdate       = Carbon::now()->addDays(-30)->format('d-m-Y');
                $todate         = Carbon::now()->addDays(30)->format('d-m-Y');
                $search         = (object)[
                    'reportdate'  => $request->get('reportdate', $fromdate.' - '.$todate),
                    'order_by'    => $request->get('order_by','id|desc'),
                    'pro_id'      => $request->get('pro_id', 0),
                    'warehouse_id'  => $request->get('warehouse_id', $user->warehouse_id),
                    'type_discount' => $request->get('type_discount', 0)
                ];
                if ($search->reportdate) {
                    $time     = explode(' - ', trim($search->reportdate), 2);
                    $fromdate = date('d-m-Y', strtotime($time[0]));
                    $todate   = date('d-m-Y', strtotime($time[1]));
                }
                $orders_by = [
                    ['id' => 'id|asc',        'name' => 'Ngày tạo tăng dần'],
                    ['id' => 'id|desc',       'name' => 'Ngày tạo giảm dần'],
                    ['id' => 'price|asc',     'name' => 'Giá xuất tăng dần'],
                    ['id' => 'price|desc',    'name' => 'Giá xuất giảm dần'],
                    ['id' => 'total|asc',     'name' => 'Số lượng tăng dần'],
                    ['id' => 'total|desc',     'name' => 'Số lượng giảm dần'],
                    ['id' => 'report_date|asc', 'name' => 'Ngày nhập tăng dần'],
                    ['id' => 'report_date|desc', 'name' => 'Ngày nhập giảm dần']
                ];
                $products       = ProductService::getSearchProductExport($user);
                $exports        = ExportService::getAllExport($search);
                $warehouses     = Warehouse::where('campain_id',$user->campain_id)->get();
                $discounts      = Discount::where('campain_id',$user->campain_id)->get();
                $totalDiscount  = 0;
                $totalIncome    = 0;
                // $totalPriceExport = 0;
                foreach($exports as $item){
                    $totalDiscount  += $item['discount'] * $item['total'];
                    $totalIncome    += $item['income'] * $item['total'];
                    // $totalPriceExport += $item['price_export'] * $item['total'];
                }
                return view('table.export',compact(
                    'exports',
                    'todate',
                    'fromdate',
                    'search',
                    'orders_by',
                    'products',
                    'totalDiscount',
                    'totalIncome',
                    'warehouses',
                    // 'totalPriceExport',
                    'discounts'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('listExport-catch', $e->getMessage());
            $message = $e->getMessage();
            return view('404', compact('message'));
        }
    }

    public function store(Request $request){
        $result = array('status' => true, 'message' => 'Lưu thành công', 'url' => '/export/list');
        try {
            $user   = Auth::user();
            if(Auth::check() && in_array($user->role_id, [1,2])){
                if($request->has('arrExport')){
                    $arrExport = json_decode($request->arrExport);
                    if(count($arrExport) > 0){
                        if($request->has('id')){
                            $export = Export::find($request->id);
                            if($export){
                                $item = $arrExport[0];
                                if(!empty($item->pro_id)){
                                    $inputs = [
                                        "pro_id"        => $item->pro_id,
                                        "total"         => (int)$item->total,
                                        "price_import"  => (int)$item->price_import,
                                        "price_export"  => (int)$item->price_export,
                                        "report_date"   => date('Y-m-d', strtotime($item->report_date)),
                                        "discount"      => (int)$item->discount,
                                        "income"        => (int)$item->income,
                                        "note"          => $item->note,
                                        "ship"          => (int)$item->ship,
                                        "discount_number" => (int)$item->discount_number,
                                        "warehouse_id"  => $item->warehouse_id,
                                        "type_discount" => $item->type_discount
                                    ];
                                    $export->update($inputs);
                                }else{
                                    $result['status']  = false;
                                    $result['message'] = "Thiếu id sản phẩm"; 
                                }
                            }else{
                                $result['status']  = false;
                                $result['message'] = "Không tồn tại bản ghi";
                            }
                        }else{
                            // Tạo mới
                            foreach($arrExport as $item){
                                if(!empty($item->pro_id)){
                                    $inputs = [
                                        "pro_id"        => $item->pro_id,
                                        "total"         => (int)$item->total,
                                        "price_import"  => (int)$item->price_import,
                                        "price_export"  => (int)$item->price_export,
                                        "report_date"   => date('Y-m-d', strtotime($item->report_date)),
                                        "discount"      => (int)$item->discount,
                                        "income"        => (int)$item->income,
                                        "note"          => $item->note,
                                        "created_by"    => $user->id,
                                        "ship"          => (int)$item->ship,
                                        "discount_number" => (int)$item->discount_number,
                                        "warehouse_id"  => $item->warehouse_id,
                                        "type_discount" => $item->type_discount,
                                        "campain_id"    => $user->campain_id
                                    ];
                                    Export::create($inputs);
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
            }else{
                return view('dashboard');
            }
        } catch (Exception $e) {
            $result['status']  = false;
            $result['message'] = $e->getMessage();
            LogActivityService::addToLog('storeExport-catch', $e->getMessage());
            return response()->json($result, 200);
        }
    }
}