import 'package:flutter/material.dart';
import 'package:frontend/Drawer/MydrawerDK.dart';

class DataKaryawan extends StatefulWidget {
  const DataKaryawan({super.key});

  @override
  State<DataKaryawan> createState() => _DataKaryawanState();
}

class _DataKaryawanState extends State<DataKaryawan> {
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
            child: Text('Data Karyawan',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      drawer: MyDrawerDK(),
    );
  }
}
