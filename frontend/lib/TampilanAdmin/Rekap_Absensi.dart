import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RekapAbsensi extends StatefulWidget {
  const RekapAbsensi({super.key});

  @override
  State<RekapAbsensi> createState() => _RekapAbsensiState();
}

class _RekapAbsensiState extends State<RekapAbsensi> {
  final List<String> karyawan = [
    'Budi', 'Siti', 'Ani', 'Joko', 'Rina', 'Rudi', 'Dewi'
  ];

  int tahun = DateTime.now().year;
  int bulan = DateTime.now().month;

  List<Map<String, dynamic>> getHariDalamBulan() {
    final List<Map<String, dynamic>> hariList = [];
    final totalHari = DateUtils.getDaysInMonth(tahun, bulan);

    for (int i = 1; i <= totalHari; i++) {
      final date = DateTime(tahun, bulan, i);
      final hari = DateFormat.E().format(date); // short day name
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
      drawer: _buildDrawer(context),
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
                // Kartu Bulan
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

                // Dropdown Tahun
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
                            child: Center(
                              child: Text("No", textAlign: TextAlign.center),
                            )),
                        const TableCell(
                            child: Center(child: Text("Nama"))),
                        ...hariList.map((hari) => TableCell(
                          child: Container(
                            color: hari['hari'] == 'Sun'
                                ? Colors.grey[200]
                                : Colors.grey[100],
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(hari['hari'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(hari['tanggal'].toString()),
                              ],
                            ),
                          ),
                        ))
                      ]),

                      // Data karyawan
                      ...List.generate(karyawan.length, (index) {
                        return TableRow(children: [
                          TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(child: Text("${index + 1}")))),
                          TableCell(
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(karyawan[index]))),
                          ...hariList.map((_) => const TableCell(
                            child: SizedBox(
                              height: 30,
                              child: Center(child: Text("")),
                            ),
                          ))
                        ]);
                      })
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

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

