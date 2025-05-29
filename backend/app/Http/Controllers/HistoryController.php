<?php

namespace App\Http\Controllers;

use App\Models\History;
use App\Http\Requests\HistoryRequest;
use Illuminate\Http\Request;

class HistoryController extends Controller
{
    public function index()
    {
        try {
            $data = History::with('users')->latest()->get();

            return response()->json([
                'status' => true,
                'status_code' => 200,
                'data' => $data,
                'message' => 'List data history berhasil diambil'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'status_code' => 500,
                'message' => $e->getMessage(),
                'data' => []
            ], 500);
        }
    }

    public function store(HistoryRequest $request)
    {
        try {
            $data = $request->validated();
            $history = History::create($data);

            return response()->json([
                'status' => true,
                'status_code' => 201,
                'message' => 'History berhasil dibuat',
                'data' => $history
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'status_code' => 500,
                'message' => $e->getMessage(),
                'data' => []
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $history = History::with('users')->findOrFail($id);

            return response()->json([
                'status' => true,
                'status_code' => 200,
                'data' => $history,
                'message' => 'Detail history ditemukan'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'status_code' => 404,
                'message' => 'Data tidak ditemukan',
                'data' => []
            ], 404);
        }
    }

    public function destroy($id)
    {
        try {
            $deleted = History::destroy($id);

            if (!$deleted) {
                return response()->json([
                    'status' => false,
                    'status_code' => 404,
                    'message' => 'Data tidak ditemukan atau sudah dihapus',
                ], 404);
            }

            return response()->json([
                'status' => true,
                'status_code' => 200,
                'message' => 'Data history berhasil dihapus',
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'status_code' => 500,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
