import 'package:flutter/material.dart';
import 'package:frontend/Drawer/MydrawerRekap.dart';

class RekapAbsensi extends StatelessWidget {
  const RekapAbsensi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffceee8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Color(0xfff09e84),
            title: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Rekap Absensi',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        drawer: MyDrawerRekap());
  }
}
