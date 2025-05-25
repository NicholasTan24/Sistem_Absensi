import 'package:flutter/material.dart';
import 'package:frontend/TampilanAdmin/Dashboard.dart';
import 'package:frontend/TampilanAdmin/Data_Karyawan.dart';
import 'package:frontend/TampilanAdmin/Login.dart';
import 'package:frontend/TampilanAdmin/Register.dart';
import 'package:frontend/TampilanAdmin/Rekap_Absensi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/dashboard':(context)=>Dashboard(),
      '/data_karyawan':(context)=> DataKaryawan(),
      '/rekap_absensi':(context)=>RekapAbsensi(),
      '/register':(context)=> Register(),
    },
  ));
}

