import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Dummy/kehadiran_dummy.dart';
import '../../drawer/Admindrawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> semuaKaryawan = dummyData().semuaKaryawan;
  List<Map<String, dynamic>> get absensiHariIni => dummyData().absensiHariIni;

  late AnimationController _hadirController;
  late AnimationController _izinController;
  late AnimationController _alphaController;

  late Animation<int> _hadirAnim;
  late Animation<int> _izinAnim;
  late Animation<int> _alphaAnim;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }



  void _setupAnimations() {
    int hadir = getJumlah("Hadir");
    int izin = getJumlah("Izin");
    int alpha = semuaKaryawan.length - hadir - izin;

    _hadirController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _izinController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _alphaController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _hadirAnim = IntTween(begin: 0, end: hadir).animate(_hadirController);
    _izinAnim = IntTween(begin: 0, end: izin).animate(_izinController);
    _alphaAnim = IntTween(begin: semuaKaryawan.length, end: alpha)
        .animate(_alphaController);

    _hadirController.forward();
    _izinController.forward();
    _alphaController.forward();
  }

  int getJumlah(String status) =>
      dummyData().absensiHariIni.where((a) => a["status"] == status).length;

  void showQRCodeDialog() {
    final tanggal = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final expired = DateFormat('HH:mm')
        .format(DateTime.now().copyWith(hour: 23, minute: 59));
    final qrUrl =
        'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=absensi-$tanggal';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("QR Hari Ini", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(qrUrl),
            const SizedBox(height: 8),
            Text("Tanggal: $tanggal"),
            Text("Expired: $expired"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hadirController.dispose();
    _izinController.dispose();
    _alphaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: showQRCodeDialog,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            _buildStatusCard("Hadir", _hadirAnim, Colors.green),
            const SizedBox(width: 12),
            _buildStatusCard("Izin", _izinAnim, Colors.orange),
            const SizedBox(width: 12),
            _buildStatusCard("Alpha", _alphaAnim, Colors.red),
          ]),
          const SizedBox(height: 40),
          const Text("Data Scan Hari Ini",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 35),
          Expanded(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text("Tanggal",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 3,
                            child: Text("Nama Karyawan",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 2,
                            child: Text("Status",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const Divider(thickness: 1),

                    // Isi data
                    ...absensiHariIni.map((data) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3, child: Text(data["tanggal"] ?? "-")),
                            Expanded(
                                flex: 3,
                                child: Text(data["namaKaryawan"] ?? "-")),
                            Expanded(
                                flex: 2, child: Text(data["status"] ?? "-")),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildStatusCard(String title, Animation<int> animation, Color color) {
    return Expanded(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Card(
            color: color.withOpacity(0.1),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color)),
                  const SizedBox(height: 8),
                  Text("${animation.value} orang",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
