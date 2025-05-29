<?php


namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RegisterRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'id_karyawan' => ['required', 'regex:/^[0-9]+$/', 'unique:users,id_karyawan'],
            'nama_karyawan' => ['required', 'max:100'],
            'email' => 'required|email:rfc,dns|unique:users,email',
            'nomor_telepon' => ['required', 'regex:/^[0-9]+$/'],
            'kd_jabatan' => ['required'],
            'status' => 'required|in:aktif,nonaktif',
            'password' => [
            'required',
            'string',
            'min:8',
            'regex:/^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).+$/',
            'confirmed'
            ],

            'role'=> 'required|in:admin,karyawan',
        ];
    }

    public function messages(): array
    {
        return [
            'id_karyawan.required' => 'ID wajib diisi',
            'id_karyawan.regex' => 'ID hanya boleh angka',
            'id_karyawan.unique' => 'ID ini sudah digunakan',

            'nama_karyawan.required' => 'Nama wajib diisi',

            'email.required' => 'Email wajib diisi',
            'email.email' => 'Format email tidak valid',

            'nomor_telepon.required' => 'Nomor telepon wajib diisi',
            'nomor_telepon.regex' => 'Nomor telepon hanya boleh angka',

            'jabatan.required' => 'Jabatan wajib diisi',
            'status.required' => 'Status wajib diisi',

            'password.required' => 'Password wajib diisi',
            'password.min' => 'Password minimal 8 karakter',
            'password.regex' => 'Password harus mengandung simbol dan huruf besar',
            'password.confirmed' => 'Konfirmasi password tidak cocok',
        ];
    }
}

