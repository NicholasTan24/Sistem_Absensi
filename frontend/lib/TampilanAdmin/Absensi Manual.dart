import 'package:flutter/material.dart';

class AbsensiManualPage extends StatefulWidget {
  const AbsensiManualPage({super.key});

  @override
  State<AbsensiManualPage> createState() => _AbsensiManualPageState();
}

class _AbsensiManualPageState extends State<AbsensiManualPage> {
  final List<Map<String, dynamic>> karyawanList = [
    {'id': 1, 'nama': 'Budi'},
    {'id': 2, 'nama': 'Siti'},
    {'id': 3, 'nama': 'Joko'},
    {'id': 4, 'nama': 'Ani'},
  ];

  late List<String> selectedStatus;
  late List<TextEditingController> keteranganControllers;

  @override
  void initState() {
    super.initState();
    selectedStatus = List.filled(karyawanList.length, 'Alpha');
    keteranganControllers = List.generate(
      karyawanList.length,
          (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (var controller in keteranganControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitAbsensi() {
    for (int i = 0; i < karyawanList.length; i++) {
      print('ID: ${karyawanList[i]['id']}');
      print('Status: ${selectedStatus[i]}');
      print('Keterangan: ${keteranganControllers[i].text}');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Absensi berhasil disimpan')),
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
      appBar: AppBar(title: const Text('Absensi Manual')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Form Absensi Manual',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: DataTable(
                    columnSpacing: 24,
                    headingRowColor: MaterialStateProperty.all(Colors.blue[100]),
                    border: TableBorder.all(color: Colors.grey),
                    columns: const [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Keterangan')),
                    ],
                    rows: List.generate(karyawanList.length, (index) {
                      return DataRow(cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(karyawanList[index]['nama'])),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: ['Hadir', 'Izin', 'Alpha'].map((status) {
                            return Row(
                              children: [
                                Radio<String>(
                                  value: status,
                                  groupValue: selectedStatus[index],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedStatus[index] = value!;
                                    });
                                  },
                                ),
                                Text(status),
                              ],
                            );
                          }).toList(),
                        )),
                        DataCell(
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: keteranganControllers[index],
                              decoration: const InputDecoration(
                                hintText: 'Isi jika perlu...',
                                border: OutlineInputBorder(),
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitAbsensi,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Absensi Manual'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
