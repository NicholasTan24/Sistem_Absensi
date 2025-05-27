<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class KaryawanRequest extends FormRequest
{

    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            "id_karyawan" => "required",
            "nama_karyawan" => "required|max: 100",
            "password" => "required|confirmed|min:6",
            "email" => "required",
            "nomor_telepon" => "required",
            "jabatan" => "required",
            "status" => "required"
        ];
    }
}
