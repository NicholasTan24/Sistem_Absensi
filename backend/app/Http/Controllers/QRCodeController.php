<?php

namespace App\Http\Controllers;

use App\Http\Requests\QRCodeRequest;
use App\Models\qr_code;
use Illuminate\Http\Request;

class QRCodeController extends Controller
{
    public function index()
    {
        $data = qr_code::all();
        return response()->json([
            'status' => true,
            'data' => $data,
        ]);
    }

    public function store(QRCodeRequest $request)
    {
        $data = qr_code::create($request->validated());

        return response()->json([
            'status' => true,
            'message' => 'QR Code created',
            'data' => $data,
        ], 201);
    }

    public function show($id)
    {
        $data = qr_code::findOrFail($id);

        return response()->json([
            'status' => true,
            'data' => $data,
        ]);
    }

    public function update(QRCodeRequest $request, $id)
    {
        $qrCode = qr_code::findOrFail($id);
        $qrCode->update($request->validated());

        return response()->json([
            'status' => true,
            'message' => 'QR Code updated',
            'data' => $qrCode,
        ]);
    }

    public function destroy($id)
    {
        $qrCode = qr_code::findOrFail($id);
        $qrCode->delete();

        return response()->json([
            'status' => true,
            'message' => 'QR Code deleted',
        ]);
    }


    public function aktifHariIni()
    {
        $qrCode = qr_code::whereDate('waktu_habis', now()->toDateString())->first();

        return response()->json([
            'status' => true,
            'data' => $qrCode,
        ]);
    }
}

