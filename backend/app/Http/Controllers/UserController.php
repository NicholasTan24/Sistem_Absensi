<?php

namespace App\Http\Controllers;

use App\Http\Requests\UserRequest;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function index(Request $request)
    {
        try {
            $search = $request->search ?? null;
            $asc = $request->order == "true" ? true : false;

            $data = User::query()->orderBy("nama_karyawan", $asc ? "ASC" : "DESC");

            if ($search) {
                $data = $data->where('nama_karyawan', 'LIKE', "%{$search}%");
            }
            $data = $data->paginate(5);

            return response()->json([
                "status" => true,
                "status_code" => 200,
                "data" => $data
            ], 200);
        } catch (\Exception $err) {
            return response()->json([
                "status" => false,
                "status_code" => 500,
                "data" => []
            ], 500);
        }
    }

    public function generateIdKaryawan()
    {
        $latest = User::orderBy('id_karyawan', 'desc')->first();
        $lastCode = $latest ? intval(substr($latest->id_karyawan, -3)) : 0;
        $newCode = str_pad($lastCode + 1, 3, '0', STR_PAD_LEFT);
        return 'K-' . $newCode;
    }

    public function store(UserRequest $request)
    {
        try {
            
            $validated = $request->validated();

            $validated['password'] = Hash::make($validated['password']);

            $data = User::create($validated);

            return response()->json([
                "status" => true,
                "status_code" => 201,
                "message" => "Successful insert karyawan",
                "data" => $data
            ], 201);

        } catch (\Exception $err) {
            return response()->json([
                "status" => false,
                "status_code" => 500,
                "message" => $err->getMessage(),
                "data" => []
            ], 500);
        }
    }

    public function show(string $id)
    {
        $data = User::findOrFail($id);
        return response()->json([
            "data" => [$data],
            "status" => true,
            "status_code" => 200,
            "message" => "Successful fetch karyawan",
        ], 200);
    }

    public function update(UserRequest $request, string $id)
{
    try {
        $data = $request->validated();

        $karyawan = User::findOrFail($id);

        // Jika ada password, encrypt dan simpan
        if (!empty($request->password)) {
            $data['password'] = Hash::make($request->password);
        } else {
            unset($data['password']);
        }

        $karyawan->update($data);

        return response()->json([
            "status" => true,
            "status_code" => 200,
            "message" => "Successful update karyawan",
            "data" => $karyawan
        ], 200);

    } catch (\Exception $err) {
        return response()->json([
            "status" => false,
            "status_code" => 500,
            "message" => $err->getMessage(),
            "data" => []
        ], 500);
    }
}

    public function destroy(string $id)
    {
        try {
            $karyawan = User::findOrFail($id);
            $karyawan->delete();
            return response()->json([
                "status" => true,
                "status_code" => 200,
                "message" => "Karyawan deleted successfully"
            ], 200);
        } catch (\Exception $err) {
            return response()->json([
                "status" => false,
                "status_code" => 500,
                "message" => $err->getMessage(),
                "data" => []
            ], 500);
        }
    }
}
class AdminController extends Controller
{
    public function index()
    {
        return response()->json(User::with('users')->get(), 200);
    }

    public function store(UserRequest $request)
    {
       try {
        $validated = $request->validated();

        $validated['password'] = Hash::make($validated['password']);

        $admin = User::create($validated);

        return response()->json([
            "status" => true,
            "status_code" => 201,
            "message" => "Admin berhasil ditambahkan",
            "data" => $admin
        ], 201);

    } catch (\Exception $err) {
        return response()->json([
            "status" => false,
            "status_code" => 500,
            "message" => $err->getMessage(),
            "data" => []
        ], 500);
    }
    }

    public function show($id)
    {
        $admin = User::with('users')->findOrFail($id);
        return response()->json($admin, 200);
    }

    public function update(UserRequest $request, string $id)
{
    try {
        $data = $request->validated();

        $admin = User::findOrFail($id);

        if (!empty($data['password'])) {
            $data['password'] = Hash::make($data['password']);
        } else {
            unset($data['password']);
        }

        $admin->update($data);

        return response()->json([
            "status" => true,
            "status_code" => 200,
            "message" => "Successful update admin",
            "data" => $admin
        ], 200);

    } catch (\Exception $err) {
        return response()->json([
            "status" => false,
            "status_code" => 500,
            "message" => $err->getMessage(),
            "data" => []
        ], 500);
    }
}

    public function destroy($id)
    {
        User::destroy($id);
        return response()->json(["message" => "Admin deleted"], 200);
    }
}

