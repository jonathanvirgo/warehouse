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
use App\Models\Pay;
use App\Models\Export;
use App\Models\Product;
use App\Models\Warehouse;
use Exception;

class ImportController extends Controller
{
    public function index(Request $request, $id = null){
        $import     = collect([]);
        try {
            if(Auth::check()){
                $user       = Auth::user();
                $products   = ProductService::getSearchProduct($user);
                $today      = date('d-m-Y', strtotime(Carbon::today()));
                $warehouses = Warehouse::where('campain_id',$user->campain_id)->get();
                if(!empty($id)){
                    $import = Import::find($id);
                }
                return view('common.import',compact(
                    'products',
                    'today',
                    'warehouses',
                    'import'
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
        $result = array('status' => true, 'message' => 'Lưu thành công', 'url' => '/import/list');

        try {
            if($request->has('arrImport') && Auth::check()){
                $user   = Auth::user();
                $arrImport = json_decode($request->arrImport);
                if(count($arrImport) > 0){
                    if($request->has('id')){
                        // nếu sửa import
                        $import = Import::find($request->id);
                        if($import){
                            // dữ liệu sửa
                            $item = $arrImport[0];
                            // nếu còn công nợ
                            $debt = Debt::where("pro_id", $import->pro_id)->where('warehouse_id',$import->warehouse_id)->where("price", $import->price)->first();
                            // chênh lệch dữ liệu sửa và dữ liệu gốc
                            $changeTotal = $item->total - $import->total;
                            //Không trống công nợ
                            if(!empty($debt)){
                                // Giảm số lượng
                                if($changeTotal <= 0){
                                    //Số công nợ lớn hơn số giảm
                                    if($debt->total >= abs($changeTotal)){
                                        $debt->update(["total" => ($debt->total + $changeTotal)]);
                                    }else{
                                        $result['status'] = false;
                                        $result['message'] = "Số lượng giảm lớn hơn số lượng còn lại";
                                        return response()->json($result, 200);
                                    }
                                }else{
                                    // Tăng nhập hàng tăng công nợ
                                    $debt->update(["total" => ($debt->total + $changeTotal)]);
                                }
                            }else{
                                // không có công nợ không được sửa nhập hàng
                                $result['status'] = false;
                                $result['message'] = "Đã thanh toán hết số lượng sản phẩm";
                                return response()->json($result, 200);
                            }
                            $inputs = [
                                "pro_id"        => $item->pro_id,
                                "total"         => (int)$item->total,
                                "price"         => (int)$item->price,
                                "report_date"   => date('Y-m-d', strtotime($item->report_date)),
                                "note"          => $item->note,
                                "warehouse_id"  => $item->warehouse_id
                            ];
                            $import->update($inputs);
                        }else{
                            $result['status']  = false;
                            $result['message'] = "Không tồn tại bản ghi";
                        }
                    }else{
                        foreach($arrImport as $item){
                            $inputs = [
                                "pro_id"        => $item->pro_id,
                                "total"         => (int)$item->total,
                                "price"         => (int)$item->price,
                                "report_date"   => date('Y-m-d', strtotime($item->report_date)),
                                "note"          => $item->note,
                                "created_by"    => $user->id,
                                "warehouse_id"  => $item->warehouse_id,
                                "campain_id"    => $user->campain_id
                            ];
                            Import::create($inputs);
                            if($item->paied == false){
                                $dept = Debt::where("pro_id", $item->pro_id)->where("price", (int)$item->price)->where("warehouse_id", $item->warehouse_id)->first();
                                if($dept){
                                    $total = $dept->total + $inputs['total'];
                                    $dept->update(["total" => $total]);
                                }else{
                                    Debt::create($inputs);
                                }
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
        try {
            if(Auth::check()){
                $user       = Auth::user();
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
                $products       = ProductService::getSearchProductImport($user);
                $imports        = ImportService::getAllImport($search);
                $totalPrice     = 0;
                if($user->role_id == 4){
                    $warehouses     = Warehouse::where('id', $user->warehouse_id)->get();
                }else{
                    $warehouses = Warehouse::where('campain_id',$user->campain_id)->get();
                }
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

    public function delete(Request $request){
        $user       = Auth::user();
        $result = array('status' => true, 'message' => 'Xoá thành công', 'url' => '/import/list');
        try {
            if($request->has('id') && Auth::check() && in_array($user->role_id, [1,2])){
                switch($request->type){
                    case 1:
                        $import = Import::find($request->id);
                        if($import){
                            $debt = Debt::where("pro_id", $import->pro_id)->where("price", $import->price)->first();
                            if(!empty($debt) && $debt->total >= $import->total){
                                $debt->update(["total" => ($debt->total - $import->total)]);
                                $import->delete();
                            }else{
                                $result['status'] = false;
                                $result['message'] = "Số lượng nhập xoá đi lớn hơn số lượng còn lại";
                            }
                        }else{
                            $result['status'] = false;
                            $result['message'] = "Không tồn tại dữ liệu";
                        }
                        break;
                    case 2:
                        $export = Export::find($request->id);
                        if($export){
                            $export->delete();
                            $result['url'] = '/export/list';
                        }else{
                            $result['status'] = false;
                            $result['message'] = "Không tồn tại dữ liệu";
                        }
                        break;
                    case 3:
                        $pay = Pay::find($request->id);
                        if($pay){
                            $debt = Debt::where("pro_id", $pay->pro_id)->where("price", $pay->price)->first();
                            if(!empty($debt)){
                                $debt->update(["total" => ($debt->total + $pay->total)]);
                            }
                            $pay->delete();
                            $result['url'] = '/pay/list';
                        }else{
                            $result['status'] = false;
                            $result['message'] = "Không tồn tại dữ liệu";
                        }
                        break;
                    default: break;
                }
            }else{
                $result['status'] = false;
                $result['message'] = "Bạn không có quyền xoá";
            }
            return response()->json($result, 200);
        }catch (Exception $e) {
            $result['status'] = false;
            $result['message'] = $e->getMessage();
            LogActivityService::addToLog('deleteImport-catch', $e->getMessage());
            return response()->json($result, 200);
        }
    }
}