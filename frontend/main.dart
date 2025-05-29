import 'package:flutter/material.dart';
import 'package:frontend/TampilanAdmin/LoginRegister/register.dart';

import 'package:frontend/TampilanAdmin/Dashboard.dart';
import 'package:frontend/TampilanAdmin/Data_Karyawan.dart';
import 'package:frontend/TampilanAdmin/LoginRegister/Login.dart';
import 'package:frontend/TampilanAdmin/Absensi Manual.dart';
import 'package:frontend/TampilanAdmin/Rekap_Absensi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/dashboard': (context) => Dashboard(),
      '/absmanual':(context) =>AbsensiManualPage(),
      '/data_karyawan':(context)=> DataKaryawanPage(),
      '/rekap_absensi':(context)=>RekapAbsensi(),
      '/register':(context)=> RegisterPage(),
    },
  ));
}
