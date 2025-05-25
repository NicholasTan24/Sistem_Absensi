import 'package:flutter/material.dart';

class MyDrawerRekap extends StatelessWidget {
  const MyDrawerRekap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Color(0xffffa44f),
          title: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('Rekap Absensi',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.redAccent,
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/BambinoLogo.jpeg',
                    height: 140, // Besarkan sesuai kebutuhan
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sistem Absensi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Container(
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text('Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/dashboard', (route) => false);
                    },
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text('Data Karyawan',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/data_karyawan', (route) => false);
                    },
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  color: Color(0xfffab75f),
                  child: ListTile(
                    leading: Icon(Icons.file_copy, color: Colors.white),
                    title: Text('Rekap Absensi',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title:
                        Text('Logout', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
