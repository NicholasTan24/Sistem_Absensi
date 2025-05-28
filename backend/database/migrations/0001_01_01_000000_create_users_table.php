<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->string('id_karyawan')->primary(); 
            $table->string('nama_karyawan');
            $table->string('email')->unique();
            $table->string('nomor_telepon');
            $table->string('kd_jabatan');
            $table->enum('status', ['aktif', 'nonaktif'])->default('aktif');
            $table->enum('role', ['admin', 'karyawan'])->default('karyawan');
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();

            $table->foreign('kd_jabatan')->references('kd_jabatan')->on('jabatan');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};

