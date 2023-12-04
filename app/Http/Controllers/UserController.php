<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\LogActivityService;
use App\Models\Warehouse;
use App\Models\User;
use App\Models\Campain;
use Exception;

class UserController extends Controller
{
    public function index(Request $request, $id = null){
        $user     = collect([]);
        try {
            if(Auth::check()){
                $userLogin  = Auth::user();
                if($userLogin->role_id == 1){
                    $users      = User::all();
                    $warehouses = Warehouse::all();
                    $campains   = Campain::all();
                    if(!empty($id)){
                        $user = User::find($id);
                    }
                    return view('common.user',compact(
                        'warehouses',
                        'users',
                        'user',
                        'campains'
                    ));
                }else{
                    return view('dashboard');
                }
            }else{
                $message = 'Liên kết không tồn tại';
                return view('404', compact('message'));
            }
        } catch (Exception $e) {
            LogActivityService::addToLog('indexUser-catch', $e->getMessage());
            $message = $e->getMessage();
            return view('404', compact('message'));
        }
    }

    public function store(Request $request){
        $result = array('status' => false, 'message' => 'Lỗi', 'url' => '/user/profile');
        try {
            $user   = Auth::user();
            if(Auth::check() && $user->role_id == 1){
                if($request->has('id')){
                    $user = User::find($request->id);
                    if($user){
                        $inputs = [
                            "warehouse_id"      => empty($request->warehouse_id) ? null : (int)$request->warehouse_id,
                            "campain_id"        => (int)$request->campain_id,
                        ];
                        $result['status']  = true;
                        $result['message'] = "Lưu thành công";
                        $user->update($inputs);
                    }else{
                        $result['message'] = "Không tồn tại tài khoản";
                    }
                }else{
                    $result['message'] = "Thiếu id người dùng";
                }
            }
            return response()->json($result, 200);
        } catch (Exception $e) {
            $result['status']  = false;
            $result['message'] = $e->getMessage();
            LogActivityService::addToLog('storeUser-catch', $e->getMessage());
            return response()->json($result, 200);
        }
    }
}