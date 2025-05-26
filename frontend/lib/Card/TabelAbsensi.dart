import 'package:flutter/material.dart';

class TabelAbsensi extends StatefulWidget {
  const TabelAbsensi({super.key});

  @override
  State<TabelAbsensi> createState() => _TabelAbsensiState();
}

class _TabelAbsensiState extends State<TabelAbsensi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 150),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
              child: Row(
                children: [
                  Text('Tanggal'),
                  SizedBox(width: 250),
                  Text('Nama'),
                  SizedBox(width: 250),
                  Text('Waktu Masuk'),
                  SizedBox(width: 250),
                  Text('Status'),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.white
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
