<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class karyawan extends Model
{
    protected $table = "karyawan";
    protected $primaryKey = "id_karyawan";
    protected $fillable = ["id_karyawan","password","nama_karyawan","nomor_telepon","email","jabatan","status"];
    protected $autoIncrement = false;
    protected $hidden = [
        'password',
    ];
}
