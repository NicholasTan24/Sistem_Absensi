import 'package:flutter/material.dart';
import 'package:frontend/Drawer/MydrawerRekap.dart';

class RekapAbsensi extends StatelessWidget {
  const RekapAbsensi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: MyDrawerRekap(),
        ));
  }
}
