import 'package:flutter/material.dart';
import 'package:frontend/Dummy/data.dart';
import 'package:frontend/Tampilan/TampilanAdmin/Edit.dart';

class DataKaryawanPage extends StatefulWidget {
  const DataKaryawanPage({super.key});

  @override
  State<DataKaryawanPage> createState() => _DataKaryawanPageState();
}

class _DataKaryawanPageState extends State<DataKaryawanPage> {
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => EditPage(
        onUpdated: () {
          setState(() {});
        },
      ),
    );
  }

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
                Navigator.pushNamed(context, '/data_karyawan');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
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
              onPressed: _showEditDialog,
              child: const Text('Edit'),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
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
                  ],
                  rows: dummyKaryawan.map((karyawan) {
                    final isActive = karyawan.status.toLowerCase() == 'aktif';
                    final textStyle = TextStyle(color: isActive ? Colors.black : Color(0xffd1d1d1));
                    return DataRow(
                      cells: [
                        DataCell(Text(karyawan.idKaryawan, style: textStyle)),
                        DataCell(Text(karyawan.namaKaryawan, style: textStyle)),
                        DataCell(Text(karyawan.email, style: textStyle)),
                        DataCell(Text(karyawan.nomorTelepon, style: textStyle)),
                        DataCell(Text(karyawan.jabatan, style: textStyle)),
                        DataCell(Text(karyawan.status, style: textStyle)),

                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
