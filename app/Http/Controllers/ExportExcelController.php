<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\LogActivityService;
use App\Exports\DebtExport;
use Maatwebsite\Excel\Facades\Excel;
use Exception;

class ExportExcelController extends Controller
{
    public function debt(Request $request){
        try{
            if($request->has('warehouse_id') && $request->has('pro_id')){
                return Excel::download(new DebtExport($request->warehouse_id, $request->pro_id), 'debt_'. Carbon::now()->timestamp .'.xlsx');
            } 
        } catch (Exception $e) {
            LogActivityService::addToLog('debtExports-catch', $e->getMessage());
        }
    }
}