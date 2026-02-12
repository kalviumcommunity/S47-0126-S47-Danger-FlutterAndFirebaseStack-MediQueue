import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class PatientData {
  final String id;
  final String name;
  final String phone;
  PatientData({required this.id, required this.name, required this.phone});
  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
  );
}

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);
  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _hasPermission = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() => _hasPermission = status.isGranted);
    if (!status.isGranted) {
      setState(() => _error = 'Camera permission denied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Scan Patient QR')),
        body: Center(child: Text(_error!, style: const TextStyle(color: Colors.red))),
      );
    }
    if (!_hasPermission) {
      return Scaffold(
        appBar: AppBar(title: const Text('Scan Patient QR')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Patient QR')),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      _handleScannedData(scanData.code);
    });
  }

  void _handleScannedData(String? data) {
    if (data != null) {
      try {
        final patientData = _parseQRData(data);
        Navigator.pop(context, patientData);
      } catch (e) {
        setState(() => _error = 'Invalid QR code format.');
      }
    }
  }

  PatientData _parseQRData(String qrCode) {
    final json = jsonDecode(qrCode);
    return PatientData.fromJson(json);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
