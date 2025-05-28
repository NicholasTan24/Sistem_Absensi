<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(LoginRequest $request)
    {
        $data = $request->validated();
        $user = null;

        if ($data['is_admin']) {
            $user = User::where('id_karyawan', $data['id_karyawan'])->with('karyawan')->first();
            if (!$user || !Hash::check($data['password'], $user->karyawan->password)) {
                return response()->json([
                    'status' => false,
                    'message' => 'ID atau password salah (Admin)',
                    'status_code' => 401
                ], 401);
            }
        } else {
            $user = User::where('id_karyawan', $data['id_karyawan'])->first();
            if (!$user || !Hash::check($data['password'], $user->password)) {
                return response()->json([
                    'status' => false,
                    'message' => 'ID atau password salah (Karyawan)',
                    'status_code' => 401
                ], 401);
            }
        }

        return response()->json([
            'status' => true,
            'message' => 'Login berhasil',
            'data' => $user,
            'status_code' => 200
        ]);
    }


    public function register(Request $request)
    {
       $data = $request->validated();

        $karyawan = User::create([
            'id_karyawan' => $data['id_karyawan'],
            'nama_karyawan' => $data['nama_karyawan'],
            'email' => $data['email'],
            'nomor_telepon' => $data['nomor_telepon'],
            'jabatan' => $data['jabatan'],
            'status' => $data['status'],
            'password' => Hash::make($data['password']),
    ]);

        return response()->json([
            'status' => true,
            'message' => 'Register berhasil',
            'data' => $karyawan
        ], 201);
    }


public function logout(Request $request)
{
    try {
        $user = Auth::user();
        if ($user) {
            $request-> $user->currentAccessToken()->delete();
            return response()->json([
                'status' => true,
                'message' => 'Berhasil logout',
                'status_code' => 200
            ]);
        }

        return response()->json([
            'status' => false,
            'message' => 'Tidak ada user yang login',
            'status_code' => 401
        ], 401);
    } catch (\Exception $e) {
        return response()->json([
            'status' => false,
            'message' => 'Gagal logout',
            'error' => $e->getMessage(),
            'status_code' => 500
        ], 500);
    }
}
}
