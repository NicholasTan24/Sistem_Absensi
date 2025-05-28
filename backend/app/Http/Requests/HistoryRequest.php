<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class HistoryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'id_karyawan' => 'required|exists:karyawan,id_karyawan',
            'periode_awal' => 'required|date',
            'periode_akhir' => 'required|date|after_or_equal:periode_awal',
            'total_hadir' => 'required|integer|min:0',
            'total_izin' => 'required|integer|min:0',
            'total_alpha' => 'required|integer|min:0',
        ];
    }
}


