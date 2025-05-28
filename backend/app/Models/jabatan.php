<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class jabatan extends Model
{
    protected $table = "jabatan";
    protected $primaryKey = "kd_jabatan";
    protected $fillable = ["nama_jabatan"];
    protected $autoIncrement = false;
    
}
