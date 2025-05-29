<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class QRCodeRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'kode_qr' => 'required|string|unique:qr_codes,kode_qr',
            'waktu_habis' => 'required|date',
        ];
    }
}

