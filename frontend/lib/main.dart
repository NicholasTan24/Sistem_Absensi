import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'Tampilan/TampilanAdmin/Absensi_Manual.dart';
import 'Tampilan/TampilanAdmin/Dashboard.dart';
import 'Tampilan/TampilanAdmin/Data_Karyawan.dart';
import 'Tampilan/TampilanAdmin/LoginRegister/Login.dart';
import 'Tampilan/TampilanAdmin/LoginRegister/register.dart';
import 'Tampilan/TampilanAdmin/Rekap_Absensi.dart';
import 'Tampilan/TampilanKaryawan/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await _requestPermissions();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const Login(),
      '/karyawan': (context) => const KaryawanPage(),
      '/dashboard': (context) => const Dashboard(),
      '/absmanual': (context) => const AbsensiManualPage(),
      '/data_karyawan': (context) => const DataKaryawanPage(),
      '/rekap_absensi': (context) => RekapAbsensiPage(),
      '/register': (context) => const RegisterPage(),
    },
  ));
}

Future<void> _requestPermissions() async {
  final status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }
}
