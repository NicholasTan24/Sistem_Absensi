import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  int hadir = 0;
  int izin = 0;
  int alpha = 0;

  @override
  void initState() {
    super.initState();
    _hitungStatusAbsensiManual().then((_) => _setupAnimations());
  }

  Future<void> _hitungStatusAbsensiManual() async {
    final prefs = await SharedPreferences.getInstance();
    int countHadir = 0;
    int countIzin = 0;

    for (var karyawan in semuaKaryawan) {
      final id = karyawan['id_karyawan'];
      final status = dummyData()
          .absensiHariIni
          .firstWhere((a) => a['idKaryawan'] == id, orElse: () => {})['status'] ??
          prefs.getString('status_$id') ??
          'Alpha';

      if (status == 'Hadir') {
        countHadir++;
      } else if (status == 'Izin') {
        countIzin++;
      }
    }

    setState(() {
      hadir = countHadir;
      izin = countIzin;
      alpha = semuaKaryawan.length - hadir - izin;
    });
  }

  void _setupAnimations() {
    _hadirController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _izinController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _alphaController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _hadirAnim = IntTween(begin: 0, end: hadir).animate(_hadirController);
    _izinAnim = IntTween(begin: 0, end: izin).animate(_izinController);
    _alphaAnim = IntTween(begin: semuaKaryawan.length, end: alpha).animate(_alphaController);

    _hadirController.forward();
    _izinController.forward();
    _alphaController.forward();
  }

  void showQRCodeDialog() {
    final tanggal = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final expired = DateFormat('HH:mm').format(DateTime.now().copyWith(hour: 23, minute: 59));
    final qrUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=absensi-$tanggal';

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
    final dataScan = absensiHariIni.where((a) => a['status'] == 'Hadir').toList();

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
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(flex: 3, child: Text("Tanggal", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 3, child: Text("Nama Karyawan", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 2, child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const Divider(thickness: 1),
                    ...dataScan.map((data) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text(data["tanggal"] ?? "-")),
                            Expanded(flex: 3, child: Text(data["namaKaryawan"] ?? data["nama"] ?? "-")),
                            Expanded(flex: 2, child: Text(data["status"] ?? "-")),
                          ],
                        ),
                      );
                    }).toList(),
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                  const SizedBox(height: 8),
                  Text("${animation.value} orang",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
