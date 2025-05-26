import 'package:flutter/material.dart';
import 'package:frontend/Card/Keterangan.dart';
import '../Drawer/Mydrawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffceee8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Color(0xfff09e84),
          title: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(children: [
              Text('Dashboard',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(Icons.qr_code_2, size: 50),
            ]),
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 70),
            child: Row(children: [
              Text(
                'Ringkasan Absensi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ]),
          ),
          CardKehadiran(),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 70),
            child: Row(children: [
              Text(
                'Riwayat Absensi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kehadiran Hari ini',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      // Text(
                      //   '${hadir + terlambat}',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 24,
                      //   ),
                      // ),
                    ],
                  ))
            ]),
          ),
        ],
      ),
    );
  }
}
