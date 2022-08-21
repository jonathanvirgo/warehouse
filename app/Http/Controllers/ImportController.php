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
use App\Models\Store;

class ImportController extends Controller
{
    public function index(Request $request){
        $user       = Auth::user();
        try {
            if(Auth::check()){
                $products = ProductService::getAllProduct();
                return view('common.import',compact(
                    'products'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('indexImport-catch', $e->getMessage());
            return $e->getMessage();
        }
    }

    public function store(Request $request){
        $user   = Auth::user();
        $result = array('status' => true, 'message' => 'Lưu thành công', 'url' => '/post/list');

        try {
            if($request->has('arrImport')){
                $arrImport = json_decode($request->arrImport);
                if(count($arrImport) > 0){
                    foreach($arrImport as $item){
                        $inputs = [
                            "pro_id"        => $item->pro_id,
                            "total"         => (int)$item->total,
                            "price"         => (int)$item->price_import,
                            "report_date"   => date('Y-m-d', strtotime($item->report_date)),
                            "note"          => $item->note,
                            "created_by"    => $user->id
                        ];
                        Import::create($inputs);
                        if($item->paied == false){
                            $dept = Debt::where("pro_id", $item->pro_id)->where("price", (int)$item->price_import)->first();
                            if($dept){
                                $total = $dept->total + $inputs['total'];
                                $dept->update(["total" => $total]);
                            }else{
                                Debt::create($inputs);
                            }
                        }
                        $store = Store::where("pro_id", $item->pro_id)->first();
                        if($store){
                            $total = $store->total + $inputs['total'];
                            $store->update(["total" => $total]);
                        }else{
                            Store::create($inputs);
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
                $todate         = Carbon::now()->addDays(60)->format('d-m-Y');
                $imports        = ImportService::getAllImport();
                $search         = (object)[
                    'reportdate'  => $request->get('reportdate', $fromdate.' - '.$todate)
                ];
                return view('table.import',compact(
                    'imports',
                    'todate',
                    'fromdate',
                    'search'
                ));
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('listImport-catch', $e->getMessage());
            return $e->getMessage();
        }
    }
}