<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('logout','LoginController@logout')->name('logout');
Route::get('login', 'LoginController@index')->name('login');
Route::post('login', 'LoginController@login');

Route::get('/', function () {
    return view('welcome');
});

Route::group(['middleware' => 'auth'], function () {
    Route::get('/', function () {return view('dashboard');});
    Route::get('dashboard', 'DashboardController@index')->name('dashboard');
    Route::get('import/index', 'ImportController@index');
    Route::get('export/index', 'ExportController@index');
    Route::get('pay/index', 'PayController@index');
    Route::post('import/store', 'ImportController@store');
    Route::get('import/list', 'ImportController@list');
    Route::post('pay/store', 'PayController@store');
    Route::get('pay/list', 'PayController@list');
    Route::get('export/list', 'ExportController@list');
});

Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();
});
