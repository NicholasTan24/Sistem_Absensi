import 'package:flutter/material.dart';
import 'package:frontend/Dummy/data.dart';
import 'package:frontend/Tampilan/TampilanAdmin/Edit.dart';
import 'package:frontend/drawer/drawer.dart';

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
      drawer: MyDrawer(),
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
