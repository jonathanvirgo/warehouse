<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Services\UserService;

class LoginController extends Controller
{
    public function index(Request $request)
    {
        Auth::logout();
        return view('login');
    }

    public function logout(Request $request) {
        Auth::logout();
        return Redirect('login');
    }

    public function login(Request $request){
        $rules = [
            'email'                 => 'required',
            'password'              => 'required'
        ];       
        $messages = [
            'email.required'                 => 'Tên đăng nhập được yêu cầu!',
            'password.required'              => 'Mật khẩu được yêu cầu!'
        ];

        $validator  = \Validator::make($request->all(), $rules, $messages);
        if ($validator->fails()) {
            return redirect("login")->withErrors($validator)->withInput();
        }

        // Nếu dữ liệu hợp lệ sẽ kiểm tra trong csdl
        $email    = $request->input('email');
        $password = $request->input('password');

         if(filter_var($email, FILTER_VALIDATE_EMAIL)) {
            if(Auth::attempt(['email' => $email, 'password' => $password])) {
                // Kiểm tra đúng email và mật khẩu sẽ chuyển trang
                return redirect()->route('dashboard');
            } else {
                // Kiểm tra không đúng sẽ hiển thị thông báo lỗi
                return redirect('login')->withErrors(['Email hoặc mật khẩu không đúng!'])->withInput();
            }
        }
    }
}