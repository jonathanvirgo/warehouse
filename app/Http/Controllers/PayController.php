<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\ProductService;
use App\Services\PayService;
use App\Services\LogActivityService;
use App\Models\Pay;
use App\Models\Store;

class PayController extends Controller
{
    public function index(Request $request){
        try {
            if(Auth::check()){
                $products = ProductService::getAllDebt();
                return view('common.pay',compact(
                    'products'
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
        $result = array('status' => true, 'message' => 'Lưu thành công', 'url' => '/post/list');

        try {
            if($request->has('arrPay')){
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
                        Pay::create($inputs);
                        if($item->id_debt > 0){
                            $dept = Debt::find($item->id_debt);
                            if($dept){
                                $total = $dept->total - $inputs['total'];
                                $dept->update(["total" => $total]);
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
                $pays = PayService::getAllPay();
                return view('table.pay',compact(
                    'pays'
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