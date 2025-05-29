import 'package:flutter/material.dart';

class DataKaryawanPage extends StatelessWidget {
  final List<Map<String, String>> karyawanList = [
    {
      'id_karyawan': 'KR001',
      'nama_karyawan': 'Budi Santoso',
      'email': 'budi@example.com',
      'nomor_telepon': '08123456789',
      'jabatan': 'Manager',
      'status': 'aktif',
      'role': 'karyawan',
    },
    {
      'id_karyawan': 'KR002',
      'nama_karyawan': 'Siti Aminah',
      'email': 'siti@example.com',
      'nomor_telepon': '08987654321',
      'jabatan': 'Admin',
      'status': 'nonaktif',
      'role': 'admin',
    },
  ];

  DataKaryawanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text("Sistem Absensi",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
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
                Navigator.pushNamed(context,'/data_karyawan');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Data Karyawan'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Tambah'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24.0,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Telepon')),
                  DataColumn(label: Text('Jabatan')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Role')),
                ],
                rows: karyawanList.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Text(data['id_karyawan']!)),
                      DataCell(Text(data['nama_karyawan']!)),
                      DataCell(Text(data['email']!)),
                      DataCell(Text(data['nomor_telepon']!)),
                      DataCell(Text(data['jabatan']!)),
                      DataCell(Text(data['status']!)),
                      DataCell(Text(data['role']!)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
