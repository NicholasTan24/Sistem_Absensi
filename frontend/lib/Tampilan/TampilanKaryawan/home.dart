import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  State<StatefulWidget> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
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
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text("Presensi"),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text("Presensi Kehadiran")),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(result != null ? 'Hasil: $result' : 'Scan kode QR'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;
      });
      controller.pauseCamera();
      Navigator.pop(context, result); // Kirim kembali hasilnya
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
