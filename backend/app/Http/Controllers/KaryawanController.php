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
        $latest = Karyawan::orderBy('id_karyawan', 'desc')->first();
        $lastCode = $latest ? intval(substr($latest->id_karyawan, -3)) : 0;
        $newCode = str_pad($lastCode + 1, 3, '0', STR_PAD_LEFT);
        return 'K-' . $newCode;
    }
    public function store(Request $request)
    {
        try{
            $request->validate([
                "id_karyawan" => "required",
                "nama_karyawan" => "required|max: 100",
                "password" => "required|confirmed|min:6",
                "email" => "required",
                "nomor_telepon" => "required",
                "jabatan" => "required",
                "status" => "required"
            ]);
            $data= Karyawan::create([
            "id_karyawan" => $request->id_karyawan,
            "nama_karyawan" => $request->nama_karyawan,
            "password" => $request->password,
            "nomor_telepon" => $request->nomor_telepon,
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
                "message" => "Successful insert karyawan",
                "data" => $data
        ], 201);
            
        }catch(\Exception $err){
            return response()->json([
                "status"=> false,
                "status_code"=> 500,
                "message" => $err->getMessage(),
                "data"=> []
            ], 500); 
        }
        // QR_Code::create($validateData);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $data = Karyawan::findOrFail($id);
        return response()->json([
            "data" => [$data],
            "status" => true,
            "status_code" => 200,
            "message" => "Successful fetch karyawan",
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        try{
            $validate = $request->validate([
                "nama_karyawan" => "required|max: 100",
                "password" => "required|confirmed|min:6",
                "email" => "required",
                "nomor_telepon" => "required",
                "jabatan" => "required",
                "status" => "required"
            ]);
            $data= $request->all();
            $Kdkaryawan = Karyawan::findOrFail($id);
            $Kdkaryawan->update(
               [
                "nama_karyawan" => $validate["nama_karyawan"],
                "password" => $validate["nama_karyawan"],
                "email" => $validate["email"],
                "nomor_telepon" => $validate["nomor_telepon"],
                "jabatan" => $validate["jabatan"],
                "status" => $validate["status"]
               ]
            );

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
                "message" => "Successful Update karyawan",
                "data" => $data
        ], 201);
            
        }catch(\Exception $err){
            return response()->json([
                "status"=> false,
                "status_code"=> 500,
                "message" => $err->getMessage(),
                "data"=> []
            ], 500); 
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        
    }
}
