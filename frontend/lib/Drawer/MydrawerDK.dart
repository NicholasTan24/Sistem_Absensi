import 'package:flutter/material.dart';

class MyDrawerDK extends StatelessWidget {
  const MyDrawerDK({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.redAccent,
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            color: Colors.transparent,
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
                color: Color(0xfffab75f),
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text('Data Karyawan',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: ListTile(
                  leading: Icon(Icons.file_copy, color: Colors.white),
                  title: Text('Rekap Absensi',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/rekap_absensi', (route) => false);
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text('Logout', style: TextStyle(color: Colors.white)),
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
    );
  }
}
