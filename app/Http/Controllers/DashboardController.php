<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Services\LogActivityService;

class DashboardController extends Controller
{
    public function index(Request $request){
        return view('dashboard');
    }
}