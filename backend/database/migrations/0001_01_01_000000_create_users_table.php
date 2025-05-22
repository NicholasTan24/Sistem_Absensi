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

        Schema::create('qr_code', function (Blueprint $table) {
            $table->string('kode_qr')->primary();
            $table->date('tanggal');
            $table->datetime('waktu_habis');
        });

        Schema::create('admin', function (Blueprint $table) {
            $table->string('id_admin')->primary();
            $table->string('password');
        });

        Schema::create('kehadiran', function (Blueprint $table) {
            $table->increments('no_kehadiran')->primary();
            $table->string('id_karyawan');
            $table->string('kode_qr');
            $table->date('tanggal');
            $table->datetime('jam_masuk')->nullable();
            $table->datetime('jam_pulang')->nullable();
            $table->foreign('id_karyawan')->references('id_karyawan')->on('karyawan');
            $table->foreign('kode_qr')->references('kode_qr')->on('qr_code');
        });

        Schema::create('history', function (Blueprint $table) {
            $table->increments('no_history')-> primary();
            $table->string('id_karyawan');
            $table->date('periode_awal');
            $table->date('periode_akhir');
            $table->integer('total_hadir');
            $table->integer('total_terlambat');
            $table->integer('total_izin');
            $table->integer('total_alpha');
            $table->foreign('id_karyawan')->references('id_karyawan')->on('karyawan');
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('history');
        Schema::dropIfExists('kehadiran');
        Schema::dropIfExists('admin');
        Schema::dropIfExists('qr_code');
        Schema::dropIfExists('karyawan');
    }

};
