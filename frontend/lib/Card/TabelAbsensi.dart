import 'package:flutter/material.dart';

class TabelAbsensi extends StatefulWidget {
  const TabelAbsensi({super.key});

  @override
  State<TabelAbsensi> createState() => _TabelAbsensiState();
}

class _TabelAbsensiState extends State<TabelAbsensi> {
  List<Map<String,String>> daftarAbsensi=[];

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 400,
      width: 1200,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, 
          color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 50, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Tanggal'),
                SizedBox(width: 270),
                Text('Nama'),
                SizedBox(width: 270),
                Text('Waktu Masuk'),
                SizedBox(width: 270),
                Text('Status'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Tanggal'),
                SizedBox(width: 270),
                Text('Nama'),
                SizedBox(width: 270),
                Text('Waktu Masuk'),
                SizedBox(width: 270),
                Text('Status'),

            ],),
          ],
        ),
      ),
    );
  }
}
