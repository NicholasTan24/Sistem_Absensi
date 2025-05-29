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
         Schema::create('history', function (Blueprint $table) {
            $table->increments('no_history')-> primary();
            $table->string('id_karyawan');
            $table->date('periode_awal');
            $table->date('periode_akhir');
            $table->integer('total_hadir');
            $table->integer('total_izin');
            $table->integer('total_alpha');
            $table->foreign('id_karyawan')->references('id_karyawan')->on('users');
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('history');
    }
};
