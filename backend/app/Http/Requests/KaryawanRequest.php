<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class KaryawanRequest extends FormRequest
{

    public function authorize(): bool
    {
        return false;
    }

    public function rules(): array
    {
        return [
            "id_karyawan" => "required",
            "nama_karyawan" => "required|max: 100",
            "password" => "required|confirmed",
            "email" => "required",
            "jabatan" => "required",
            "status" => "required"
        ];
    }
}
