<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\QRCodeController;
use App\Http\Controllers\KehadiranController;
use App\Http\Controllers\HistoryController;


// AUTH
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::middleware('auth:sanctum')->post('/logout', [AuthController::class, 'logout']);

// KARYAWAN
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/karyawan', [UserController::class, 'index']);
    Route::post('/karyawan', [UserController::class, 'store']);
    Route::get('/karyawan/{id}', [UserController::class, 'show']);
    Route::put('/karyawan/{id}', [UserController::class, 'update']);
    Route::delete('/karyawan/{id}', [UserController::class, 'destroy']);

    // ADMIN
    Route::get('/admin', [UserController::class, 'index']);
    Route::post('/admin', [UserController::class, 'store']);
    Route::get('/admin/{id}', [UserController::class, 'show']);
    Route::put('/admin/{id}', [UserController::class, 'update']);
    Route::delete('/admin/{id}', [UserController::class, 'destroy']);

    // QR CODE
    Route::prefix('qr-code')->group(function () {
    Route::get('/', [QRCodeController::class, 'index']);
    Route::post('/', [QRCodeController::class, 'store']);
    Route::get('/{id}', [QRCodeController::class, 'show']);
    Route::put('/{id}', [QRCodeController::class, 'update']);
    Route::delete('/{id}', [QRCodeController::class, 'destroy']);
    Route::get('/hari-ini/aktif', [QRCodeController::class, 'aktifHariIni']);
});

    // KEHADIRAN
    Route::get('/kehadiran', [KehadiranController::class, 'index']);
    Route::get('/kehadiran/today', [KehadiranController::class, 'today']);
    Route::post('/kehadiran', [KehadiranController::class, 'store']);
    Route::get('/kehadiran/{id}', [KehadiranController::class, 'show']);
    Route::delete('/kehadiran/{id}', [KehadiranController::class, 'destroy']);

    // HISTORY
    Route::get('/history', [HistoryController::class, 'index']);
    Route::get('/history/{id}', [HistoryController::class, 'show']);
    Route::post('/history', [HistoryController::class, 'store']);
    Route::delete('/history/{id}', [HistoryController::class, 'destroy']);
});
