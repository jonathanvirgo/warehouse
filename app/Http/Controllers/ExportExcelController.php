<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\LogActivityService;
use App\Exports\DebtExport;
use App\Exports\PayExport;
use App\Exports\ImportExport;
use App\Exports\ExportExport;
use App\Exports\DebtDayExport;
use Maatwebsite\Excel\Facades\Excel;
use Exception;

class ExportExcelController extends Controller
{
    public function debt(Request $request){
        try{
            $user  = Auth::user();
            if($request->has('warehouse_id') && $request->has('pro_id')){
                if(Auth::check() && in_array($user->role_id, [1,2])){
                    return Excel::download(new DebtExport($request->warehouse_id, $request->pro_id), 'debt_'. Carbon::now()->timestamp .'.xlsx');
                }
            } 
        } catch (Exception $e) {
            LogActivityService::addToLog('debtExports-catch', $e->getMessage());
        }
    }

    public function pay(Request $request){
        try{
            $user  = Auth::user();
            if($request->has('warehouse_id') && $request->has('pro_id') && $request->has('report_date')){
                if(Auth::check() && in_array($user->role_id, [1,2])){
                    return Excel::download(new PayExport($request->warehouse_id, $request->pro_id, $request->report_date), 'pay_'. Carbon::now()->timestamp .'.xlsx');
                }
            } 
        } catch (Exception $e) {
            LogActivityService::addToLog('payExports-catch', $e->getMessage());
        }
    }

        public function import(Request $request){
        try{
            $user  = Auth::user();
            if($request->has('warehouse_id') && $request->has('pro_id') && $request->has('report_date')){
                if(Auth::check() && in_array($user->role_id, [1,2])){
                    return Excel::download(new ImportExport($request->warehouse_id, $request->pro_id, $request->report_date), 'import_'. Carbon::now()->timestamp .'.xlsx');
                }
            } 
        } catch (Exception $e) {
            LogActivityService::addToLog('importExports-catch', $e->getMessage());
        }
    }

    public function export(Request $request){
        try{
            $user  = Auth::user();
            if($request->has('warehouse_id') && $request->has('pro_id') && $request->has('report_date') && $request->has('type_discount')){
                if(Auth::check() && in_array($user->role_id, [1,2])){
                    return Excel::download(new ExportExport($request->warehouse_id, $request->pro_id, $request->report_date, $request->type_discount), 'export_'. Carbon::now()->timestamp .'.xlsx');
                }
            } 
        } catch (Exception $e) {
            LogActivityService::addToLog('exportExports-catch', $e->getMessage());
        }
    }

    public function debtDay(Request $request){
        try{
            $user  = Auth::user();
            if($request->has('warehouse_id') && $request->has('report_date')){
                if(Auth::check() && in_array($user->role_id, [1,2])){
                    return Excel::download(new DebtDayExport($request->warehouse_id, $request->report_date), 'cong_no_'.$request->report_date. Carbon::now()->timestamp .'.xlsx');
                }
            } 
        } catch (Exception $e) {
            LogActivityService::addToLog('debtDayExports-catch', $e->getMessage());
        }
    }
}