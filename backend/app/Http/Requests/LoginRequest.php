<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LoginRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'id_karyawan' => ['required', 'regex:/^[0-9]+$/', 'unique:users,id_karyawan'],
            'password' => [
                'required','string',
                'min:8',
                'regex:/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$/'
            ],
        ];
    }

    public function messages(): array
    {
        return [
            'id_karyawan.required' => 'ID Karyawan wajib diisi.',
            'id_karyawan.regex' => 'ID Karyawan hanya boleh berisi angka dan tanda strip.',
            'password.required' => 'Password wajib diisi.',
            'password.min' => 'Password minimal 8 karakter dan mengandung huruf besar, huruf kecil, angka, dan simbol.',
        ];
    }
}
