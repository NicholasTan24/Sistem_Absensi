<?php

namespace App\Http\Controllers;

use App\Models\Kehadiran;
use Illuminate\Http\Request;

class KehadiranController extends Controller
{
    public function index()
    {
        return response()->json(Kehadiran::with('karyawan')->get(), 200);
    }

    public function today()
    {
        $today = now()->format('Y-m-d');
        $data = Kehadiran::whereDate('tanggal', $today)->with('karyawan')->get();
        return response()->json($data, 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_karyawan' => 'required|exists:karyawans,id',
            'tanggal' => 'required|date',
            'status' => 'required|in:hadir,izin,terlambat,tidak_hadir',
            'waktu' => 'required',
        ]);

        $data = Kehadiran::create($request->all());

        return response()->json([
            "message" => "Kehadiran dicatat",
            "data" => $data
        ], 201);
    }

    public function show($id)
    {
        return response()->json(Kehadiran::findOrFail($id), 200);
    }

    public function destroy($id)
    {
        Kehadiran::destroy($id);
        return response()->json(["message" => "Data kehadiran dihapus"], 200);
    }
}
