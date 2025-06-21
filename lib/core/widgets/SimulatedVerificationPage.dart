import 'package:flutter/material.dart';
import 'package:grad_project/core/widgets/BackButtonCircle.dart';
import 'package:grad_project/core/widgets/CreateNewPasswordPage.dart';
import 'package:grad_project/pages/DoctorPatient.dart';
import 'package:pinput/pinput.dart';

class SimulatedVerificationPage extends StatefulWidget {
  final String contactInfo;

  const SimulatedVerificationPage({Key? key, required this.contactInfo}) : super(key: key);

  @override
  _SimulatedVerificationPageState createState() => _SimulatedVerificationPageState();
}

class _SimulatedVerificationPageState extends State<SimulatedVerificationPage> {
  final TextEditingController pinController = TextEditingController();
  bool _isLoading = false;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 24, color: Colors.white),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  void _simulateVerifyCode() {
    final code = pinController.text.trim();

    if (code.length != 4 || int.tryParse(code) == null) {
      _showError('Please enter a valid 4-digit code');
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DoctorPatient()),
      );
    });
  }

  void _simulateResendCode() {
    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A new simulated code has been sent to your email.'),
          backgroundColor: Color(0xFF199A8E),
        ),
      );
    });
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 40,
              child: Icon(Icons.close, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF199A8E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Retry',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF22E0E4), Color(0xFF2C5C5D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Email Verification',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Enter code sent to\n${widget.contactInfo}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(height: 40),
                    Pinput(
                      length: 4,
                      controller: pinController,
                      defaultPinTheme: defaultPinTheme,
                      separator: const SizedBox(width: 16),
                      showCursor: true,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _simulateVerifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF199A8E),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          'Verify',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _isLoading ? null : _simulateResendCode,
                      child: const Text(
                        'Resend code',
                        style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const BackButtonCircle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}