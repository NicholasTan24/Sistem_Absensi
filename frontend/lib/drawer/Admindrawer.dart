import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String nama = '';
  String id = '';
  String email = '';
  String noTelepon = '';
  String jabatan = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('namaKaryawan') ?? '-';
      id = prefs.getString('idKaryawan') ?? '-';
      email = prefs.getString('email') ?? '-';
      noTelepon = prefs.getString('nomorTelepon') ?? '-';
      jabatan = prefs.getString('jabatan') ?? '-';
    });
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Profil Karyawan"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 35, child: Icon(Icons.person, size: 35)),
            const SizedBox(height: 10),
            Text("ID: $id"),
            Text("Nama: $nama"),
            Text("Email: $email"),
            Text("Telepon: $noTelepon"),
            Text("Jabatan: $jabatan"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _showProfileDialog,
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35),
                  ),

                ),
                const SizedBox(height: 10),
                const Text(
                  "Sistem Absensi",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Rekap Absensi"),
            onTap: () {
              Navigator.pushNamed(context, '/rekap_absensi');
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_calendar),
            title: const Text("Absensi Manual"),
            onTap: () {
              Navigator.pushNamed(context, '/absmanual');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Data Karyawan"),
            onTap: () {
              Navigator.pushNamed(context, '/data_karyawan');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
