<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\ImportService;
use App\Services\LogActivityService;

class ExportController extends Controller
{
    public function index(Request $request){
        try {
            return view('common.export');
        } catch (Exception $e) {
            LogActivityService::addToLog('indexExport-catch', $e->getMessage());
            return $e->getMessage();
        }
    }

    public function list(Request $request){
        $user       = Auth::user();
        try {
            if(Auth::check()){
                $imports = ImportService::getAllImport();
                return view('table.import',compact(
                    'imports'
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