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
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kehadiran');
    }
};
