import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScannerPage extends StatefulWidget {
  static const String routeName = 'QRScanner';

  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool _isScanning = true;
  final MobileScannerController _controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Camera permission is required to scan QR codes')),
          );
        }
      }
    }
  }

  bool _isValidUrl(String url) {
    final RegExp urlRegExp = RegExp(
      r'^(https?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$',
      caseSensitive: false,
    );
    return urlRegExp.hasMatch(url);
  }

  // Future<void> launchScannedUrl(String url) async {
  //   String sanitizedUrl = url.trim();
  //   if (!sanitizedUrl.startsWith('http://') && !sanitizedUrl.startsWith('https://')) {
  //     sanitizedUrl = 'https://$sanitizedUrl';
  //   }
  //
  //   bool isValidUrl = _isValidUrl(sanitizedUrl);
  //   print('Validating URL: $sanitizedUrl, isValid: $isValidUrl');
  //   if (!isValidUrl) {
  //     print('Invalid URL: $sanitizedUrl');
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Invalid URL: $url')),
  //       );
  //     }
  //     return;
  //   }
  //
  //   final Uri uri = Uri.parse(sanitizedUrl);
  //   try {
  //     // Use platformDefault instead of externalApplication
  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri, mode: LaunchMode.platformDefault);
  //       print('URL launched successfully: $sanitizedUrl');
  //       if (_isScanning) {
  //         setState(() {
  //           _isScanning = false;
  //           _controller.stop();
  //           print('Scanner stopped');
  //         });
  //       }
  //     } else {
  //       print('Cannot launch URL: $sanitizedUrl');
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Cannot launch $url')),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     print('Error launching URL: $e');
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error launching $url: $e')),
  //       );
  //     }
  //   }
  // }
  Future<void> _launchUrl(String urlStr) async {
    final Uri url = Uri.parse(urlStr);
    if (await canLaunchUrl(url)) {
      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        print('Could not launch $url');
      }
    } else {
      print('URL cannot be launched: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: MobileScanner(
        controller: _controller,
        onDetect: (BarcodeCapture capture) {
          if (!_isScanning) return;
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final String? scannedUrl = barcodes.first.rawValue;
            print('Raw barcode value: $scannedUrl');
            if (scannedUrl != null) {
              print('Scanned URL: $scannedUrl');
              _launchUrl(scannedUrl);
            } else {
              print('No valid URL found in QR code');
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No valid URL found in QR code')),
                );
              }
            }
          }
        },
      ),
      floatingActionButton: _isScanning
          ? null
          : FloatingActionButton(
        onPressed: () {
          setState(() {
            _isScanning = true;
            _controller.start();
            print('Scanner restarted');
          });
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}