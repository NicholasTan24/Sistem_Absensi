<?php

namespace App\Http\Controllers;

use App\Http\Requests\KaryawanRequest;
use Illuminate\Http\Request;
use App\Models\karyawan;

class KaryawanController extends Controller
{
    public function index(Request $request)
    {
        try{
            $search = $request -> search ?? null;
            $asc = $request->order == "true"? true : false;

            $data = Karyawan::query()->orderBy("nama_karyawan", $asc ? "ASC": "DESC");
            
            if($search) {
               $data =$data->whereLike('nama_karyawan', "%{$search}%");
            }
            $data  = $data->paginate(5);
            
            return response()->json([
                "status"=> true,
                "status_code"=> 200,
                "data"=> $data
            ], 200);   
        } catch(\Exception $err){
            return response()->json([
                "status"=> false,
                "status_code"=> 500,
                "data"=> []
            ], 500); 
        }
    }
    public function generateIdKaryawan() {
        $latest = Karyawan::orderBy('kd_karyawan', 'desc')->first();
        $lastCode = $latest ? intval(substr($latest->kd_kepengurusan_kelas, -3)) : 0;
        $newCode = str_pad($lastCode + 1, 3, '0', STR_PAD_LEFT);
        return 'K-' . $newCode;
    }
    public function store(KaryawanRequest $request)
    {
        $data= Karyawan::create([
            "id_karyawan" => $this->generateIdKaryawan(),
            "nama_karyawan" => $request->nama_karyawan,
            "password" => $request->password,
            "email" => $request->email,
            "jabatan" => $request->jabatan,
            "status" => $request->status
        ]);
        if(!$data){
            return response()->json([
                "status" => false,
                "status_code" => 400,
                "message" => "Bad Request",
                "data" => []
        ], 400);
        }
        return response()->json([
                "status" => true,
                "status_code" => 201,
                "message" => "Successful",
                "data" => $data
        ], 201);
        // QR_Code::create($validateData);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
