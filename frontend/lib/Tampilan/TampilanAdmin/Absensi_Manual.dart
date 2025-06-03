import 'package:flutter/material.dart';
import 'package:frontend/Dummy/kehadiran_dummy.dart';
import 'package:frontend/drawer/Admindrawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsensiManualPage extends StatefulWidget {
  const AbsensiManualPage({super.key});

  @override
  State<AbsensiManualPage> createState() => _AbsensiManualPageState();
}

class _AbsensiManualPageState extends State<AbsensiManualPage> {
  late List<String> selectedStatus;
  late List<TextEditingController> keteranganControllers;
  final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadSelectedStatus();
  }

  Future<void> _loadSelectedStatus() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> tempStatus = [];
    List<TextEditingController> tempControllers = [];

    for (int index = 0; index < dummyData().semuaKaryawan.length; index++) {
      final id = dummyData().semuaKaryawan[index]['id_karyawan'];

      final existing = dummyData().absensiHariIni.firstWhere(
            (a) => a['idKaryawan'] == id,
        orElse: () => {},
      );

      String status;
      String keterangan;

      if (existing.isNotEmpty) {
        status = existing['status'] ?? 'Alpha';
        keterangan = existing['keterangan'] ?? '';
      } else {
        status = prefs.getString('status_${id}_$today') ?? 'Alpha';
        keterangan = prefs.getString('keterangan_${id}_$today') ?? '';
      }

      tempStatus.add(status);
      tempControllers.add(TextEditingController(text: keterangan));
    }

    if (mounted) {
      setState(() {
        selectedStatus = tempStatus;
        keteranganControllers = tempControllers;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in keteranganControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitAbsensi() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < dummyData().semuaKaryawan.length; i++) {
      final id = dummyData().semuaKaryawan[i]['id_karyawan'];

      final existingIndex = dummyData().absensiHariIni.indexWhere((a) => a['idKaryawan'] == id);

      final newAbsensi = {
        'idKaryawan': id,
        'namaKaryawan': dummyData().semuaKaryawan[i]['nama_karyawan'],
        'status': selectedStatus[i],
        'waktu': DateFormat('HH:mm').format(DateTime.now()),
        'tanggal': today,
        'keterangan': keteranganControllers[i].text,
      };

      if (existingIndex != -1) {
        dummyData().absensiHariIni[existingIndex] = newAbsensi;
      } else {
        dummyData().absensiHariIni.add(newAbsensi);
      }

      await prefs.setString('status_${id}_$today', selectedStatus[i]);
      await prefs.setString('keterangan_${id}_$today', keteranganControllers[i].text);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Absensi berhasil disimpan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedStatus.isEmpty || keteranganControllers.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Absensi Manual')),
      drawer: MyDrawer(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Form Absensi Manual',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                    rows: List.generate(dummyData().semuaKaryawan.length, (index) {
                      final karyawan = dummyData().semuaKaryawan[index];
                      final id = karyawan['id_karyawan'];

                      final sudahScan = dummyData().absensiHariIni.any(
                            (a) =>
                        a['idKaryawan'] == id &&
                            a['status'] == 'Hadir',
                      );

                      return DataRow(cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(karyawan['nama_karyawan'])),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: ['Hadir', 'Izin', 'Alpha'].map((status) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<String>(
                                  value: status,
                                  groupValue: selectedStatus[index],
                                  onChanged: sudahScan
                                      ? null
                                      : (value) {
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
                                hintText: 'Isi Keterangan...',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
