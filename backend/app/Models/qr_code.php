<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class qr_code extends Model
{
    protected $table = "qr_code";
    protected $primaryKey = "kode_qr";
    protected $fillable = ["kode_qr","waktu_habis"];
    protected $autoIncrement = false;
    
}
