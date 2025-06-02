import 'package:flutter/material.dart';

import 'Tampilan/TampilanAdmin/Absensi_Manual.dart';
import 'Tampilan/TampilanAdmin/Dashboard.dart';
import 'Tampilan/TampilanAdmin/Data_Karyawan.dart';
import 'Tampilan/TampilanAdmin/LoginRegister/Login.dart';
import 'Tampilan/TampilanAdmin/LoginRegister/register.dart';
import 'Tampilan/TampilanAdmin/Rekap_Absensi.dart';
import 'Tampilan/TampilanKaryawan/home.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

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
