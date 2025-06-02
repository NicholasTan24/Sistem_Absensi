import 'package:flutter/material.dart';
import 'package:frontend/Dummy/kehadiran_dummy.dart';
import 'package:frontend/drawer/drawer.dart';
import 'package:intl/intl.dart';

import '../../Dummy/data.dart';
import '../../Dummy/dummy_data.dart';

class RekapAbsensiPage extends StatefulWidget {
  RekapAbsensiPage({super.key});
  final List<Karyawan> karyawan = dummyKaryawan;

  @override
  State<RekapAbsensiPage> createState() => _RekapAbsensiPageState();
}

class _RekapAbsensiPageState extends State<RekapAbsensiPage> {
  int tahun = DateTime.now().year;
  int bulan = DateTime.now().month;

  List<Map<String, dynamic>> getHariDalamBulan() {
    final List<Map<String, dynamic>> hariList = [];
    final totalHari = DateUtils.getDaysInMonth(tahun, bulan);

    for (int i = 1; i <= totalHari; i++) {
      final date = DateTime(tahun, bulan, i);
      final hari = DateFormat.E().format(date);
      hariList.add({'tanggal': i, 'hari': hari});
    }

    return hariList;
  }

  List<String> namaBulan = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
  ];

  List<int> daftarTahun = List.generate(5, (i) => DateTime.now().year - 2 + i);

  @override
  Widget build(BuildContext context) {
    final hariList = getHariDalamBulan();

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: const Text("Rekap Absensi")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bulan & Tahun
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        final selected = bulan == index + 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(namaBulan[index]),
                            selected: selected,
                            onSelected: (_) {
                              setState(() {
                                bulan = index + 1;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: tahun,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            tahun = value;
                          });
                        }
                      },
                      items: daftarTahun
                          .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t.toString()),
                      ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Rekap Tabel
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    border: TableBorder.all(color: Colors.black26),
                    children: [
                      // Header
                      TableRow(children: [
                        const TableCell(
                          child: Center(child: Text("No")),
                        ),
                        const TableCell(
                          child: Center(child: Text("Nama")),
                        ),
                        ...hariList.map((hari) => TableCell(
                          child: Container(
                            color: Colors.grey[200],
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  hari['hari'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(hari['tanggal'].toString()),
                              ],
                            ),
                          ),
                        )),
                      ]),
                      // Data Karyawan
                      ...List.generate(dummyKaryawan.length, (index) {
                        final karyawan = dummyKaryawan[index];
                        return TableRow(children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(child: Text("${index + 1}")),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(karyawan.namaKaryawan),
                            ),
                          ),
                          ...hariList.map((hari) {
                            final date =
                            DateTime(tahun, bulan, hari['tanggal']);
                            final formattedDate =
                            DateFormat('yyyy-MM-dd').format(date);

                            final absensi = dummyData()
                                .absensiHariIni
                                .firstWhere(
                                  (a) =>
                              a['idKaryawan'] ==
                                  karyawan.idKaryawan &&
                                  a['tanggal'] == formattedDate,
                              orElse: () => {},
                            );

                            String status = "A";
                            Color warna = Colors.red;

                            if (absensi.isNotEmpty) {
                              switch (absensi['status']) {
                                case 'Hadir':
                                  status = "H";
                                  warna = Colors.green;
                                  break;
                                case 'Izin':
                                  status = "I";
                                  warna = Colors.orange;
                                  break;
                              }
                            }

                            return TableCell(
                              child: Container(
                                height: 30,
                                color: warna,
                                child: Center(
                                  child: Text(
                                    status,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ]);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
