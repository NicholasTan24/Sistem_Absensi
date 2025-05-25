<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('karyawan', function (Blueprint $table) {
            $table->string('id_karyawan')->primary();
            $table->string('password');
            $table->string('nama_karyawan');
            $table->string('nomor_telepon')->nullable();
            $table->string('email')->unique();
            $table->string('jabatan');
            $table->enum('status',['aktif','tidak aktif']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('karyawans');
    }
};
