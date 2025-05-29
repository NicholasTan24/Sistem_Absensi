import 'package:flutter/material.dart';

class RekapKaryawanPage extends StatefulWidget {
  const RekapKaryawanPage({super.key});

  @override
  State<RekapKaryawanPage> createState() => _RekapKaryawanPageState();
}

class _RekapKaryawanPageState extends State<RekapKaryawanPage> {
  final List<String> bulanList = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
  ];

  int selectedMonth = DateTime.now().month;
  int tahun = DateTime.now().year;

  // Dummy data kehadiran 27 hari
  final List<String> kehadiran = List.generate(27, (index) => "H");

  String getPersentase() {
    int total = kehadiran.length;
    int hadir = kehadiran.where((k) => k == 'H').length;
    return "${((hadir / total) * 100).toStringAsFixed(2)} %";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rekap Kehadiran")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("BULAN", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedMonth,
                  items: List.generate(12, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text(bulanList[index]),
                    );
                  }),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedMonth = val);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: const IntrinsicColumnWidth(),
                border: TableBorder.all(color: Colors.grey.shade300),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    children: [
                      const TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("KEHADIRAN", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      ...List.generate(27, (index) {
                        return TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("${index + 1}")),
                          ),
                        );
                      }),
                      const TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("PERSENTASE", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text("")),
                        ),
                      ),
                      ...kehadiran.map((item) => TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(item)),
                        ),
                      )),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(getPersentase())),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
