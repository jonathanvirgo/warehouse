<?php
namespace App\Services;
use Request;
use App\Models\LogActivity;

class LogActivityService
{
    public static function addToLog($name, $message)
    {
        $log['name']        = $name;
        $log['message']     = $message;
        $log['url']         = Request::url();
        $log['method']      = Request::method();
        $log['agent']       = Request::header('user-agent');
        $log['user_id']     = auth()->check() ? auth()->user()->id : 1;
        $log['form_data']   = json_encode(Request::all());
        LogActivity::create($log);
    }
}
