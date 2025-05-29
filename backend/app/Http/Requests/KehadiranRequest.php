<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class KehadiranRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'id_karyawan' => 'required|exists:users,id_karyawan',
            'tanggal' => 'required|date',
            'status' => 'required|in:hadir,izin,terlambat,tidak_hadir',
            'jam_masuk' => 'required|date_format:H:i',
        ];
    }
}
