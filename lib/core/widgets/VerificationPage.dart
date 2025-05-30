import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'BackButtonCircle.dart';
import 'CreateNewPasswordPage.dart';

class VerificationPage extends StatefulWidget {
  final String contactInfo;

  const VerificationPage({required this.contactInfo});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController pinController = TextEditingController();
  bool isLoading = false;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 24,
      color: Colors.white,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(8),
    ),
  );

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
                      'Enter Verification Code',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Enter code that we have sent to\n${widget.contactInfo}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
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
                        onPressed: isLoading ? null : _verifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF199A8E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
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
                      onPressed: _resendCode,
                      child: const Text(
                        'Didn\'t receive the code? Resend',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                BackButtonCircle(), // هنا يتم استدعاء الأداة
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New code has been sent'),
        backgroundColor: Color(0xFF2C5C5D),
      ),
    );
  }

  void _verifyCode() {
    if (pinController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete code'),
          backgroundColor: Color(0xFF2C5C5D),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);
      if (pinController.text == "1234") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CreateNewPasswordPage()),
        );
      } else {
        _showFailedDialog();
      }
    });
  }

  void _showFailedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.red, // لون الدايرة الأحمر
              radius: 40,
              child: const Icon(
                Icons.close,
                color: Colors.white, // لون علامة الغلط أبيض
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'You have entered wrong code',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF199A8E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Retry',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
