<?php
namespace App\Services;

use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Pay;

class PayService
{
    public static function getAllPay(){
        try {
            $pays = Pay::with('product')->get();
            return $pays;
        } catch (Exception $e) {
            LogActivityService::addToLog('getAllProduct-catch', $e->getMessage());
        }
    }
}