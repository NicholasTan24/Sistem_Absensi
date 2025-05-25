<?php

use App\Http\Controllers\TestingController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('index');
});

Route::get('/karyawan', function () {
    return view('karyawan');
});

Route::post('/', 'RequestsController@accept');
Route::resource('testing', TestingController::class);