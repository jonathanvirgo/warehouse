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
                $fromdate       = Carbon::now()->addDays(-30)->format('d-m-Y');
                $todate         = Carbon::now()->addDays(30)->format('d-m-Y');
                $search         = (object)[
                    'reportdate'  => $request->get('reportdate', $fromdate.' - '.$todate)
                ];
                $products       = ProductService::getAllProduct();
                return view('table.product',compact(
                    'products',
                    'todate',
                    'fromdate',
                    'search'
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