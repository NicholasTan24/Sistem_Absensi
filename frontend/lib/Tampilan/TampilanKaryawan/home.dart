import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/drawer/KaryawanDrawer.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  State<KaryawanPage> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? result;
  bool isScanned = false;
  bool flashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (!kIsWeb && Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  void _onQRViewCreated(QRViewController ctrl) {
    controller = ctrl;
    controller?.scannedDataStream.listen((scanData) {
      if (!isScanned) {
        setState(() {
          result = scanData.code;
          isScanned = true;
        });
        controller?.pauseCamera();
        Navigator.pop(context, scanData.code);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: KaryawanDrawer(),
      appBar: AppBar(
        title: const Text("Presensi Kehadiran"),
        actions: [
          if (!kIsWeb)
            IconButton(
              icon: const Icon(Icons.flip_camera_android),
              onPressed: () async {
                await controller?.flipCamera();
              },
            ),
          if (!kIsWeb)
            IconButton(
              icon: Icon(flashOn ? Icons.flash_on : Icons.flash_off),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() => flashOn = !flashOn);
              },
            ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blueAccent,
                borderRadius: 12,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                result != null ? 'Hasil: $result' : 'Scan QR Codenya',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await controller?.resumeCamera();
          setState(() {
            isScanned = false;
            result = null;
          });
        },
        icon: const Icon(Icons.refresh),
        label: const Text("Ulangi Scan"),
      ),
    );
  }
}
