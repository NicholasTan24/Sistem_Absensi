import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KaryawanDrawer extends StatefulWidget {
  const KaryawanDrawer({super.key});

  @override
  State<KaryawanDrawer> createState() => _KaryawanDrawerState();
}

class _KaryawanDrawerState extends State<KaryawanDrawer> {
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
            leading: const Icon(Icons.qr_code_scanner),
            title: const Text("Presensi"),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
