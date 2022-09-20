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
Route::get('test', 'DashboardController@test');

Route::get('/', function () {
    return view('welcome');
});

Route::group(['middleware' => 'auth'], function () {
    Route::get('/', function () {return view('dashboard');});
    Route::get('dashboard', 'DashboardController@index')->name('dashboard');

    Route::get('export/index', 'ExportController@index');
    Route::post('export/store', 'ExportController@store');
    Route::get('export/list', 'ExportController@list');
    Route::get('export/edit/{id}', 'ExportController@index');
    

    Route::get('import/index', 'ImportController@index');
    Route::post('import/store', 'ImportController@store');
    Route::post('import/delete', 'ImportController@delete');
    Route::get('import/list', 'ImportController@list');
    Route::get('import/edit/{id}', 'ImportController@index');

    Route::get('pay/index', 'PayController@index');
    Route::post('pay/store', 'PayController@store');
    Route::get('pay/list', 'PayController@list');
    Route::get('pay/edit/{id}', 'PayController@index');

    Route::get('dept/list', 'PayController@deptList');
    Route::get('dept/list-day', 'PayController@deptListDay');

    Route::get('product/list', 'ProductController@list');
    Route::get('product/price', 'ProductController@getPrice');
    Route::get('product/inventory', 'ProductController@getInventory');

    Route::get('user/profile', 'UserController@index');
    Route::post('user/store', 'UserController@store');

    Route::get('export/debt', 'ExportExcelController@debt');
});

Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();
});
