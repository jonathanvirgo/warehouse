<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Import;

class ImportService
{
    public static function getAllImport(){
        try {
            $imports = Import::with('product')->get();
            return $imports;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllProduct-catch', $e->getMessage());
        }
    }
}