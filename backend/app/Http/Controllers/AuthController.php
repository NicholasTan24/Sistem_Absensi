<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function register(RegisterRequest $request)
{
    $data = $request->validated();

    try {
        $user = User::create([
            'id_karyawan' => $data['id_karyawan'],
            'nama_karyawan' => $data['nama_karyawan'],
            'email' => $data['email'],
            'nomor_telepon' => $data['nomor_telepon'],
            'kd_jabatan' => $data['kd_jabatan'],
            'status' => $data['status'],
            'role' => $data['role'],
            'password' => Hash::make($data['password']),
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Register berhasil',
            'data' => $user
        ], 201);
    } catch (\Exception $e) {
        return response()->json([
            'status' => false,
            'message' => 'Gagal register',
            'error' => $e->getMessage()
        ], 500);
    }
}


    public function login(LoginRequest $request)
    {
    $data = $request->validated();

    $user = User::where('id_karyawan', $data['id_karyawan'])->first();

    if (!$user || !Hash::check($data['password'], $user->password)) {
        return response()->json([
            'status' => false,
            'message' => 'ID atau password salah',
            'status_code' => 401
        ], 401);
    }

    return response()->json([
        'status' => true,
        'message' => 'Login berhasil',
        'data' => $user,
        'status_code' => 200
    ]);
    }


    public function logout(Request $request)
    {
        return response()->json([
        'status' => true,
        'message' => 'Logout berhasil',
        'status_code' => 200
    ]);
}
}
