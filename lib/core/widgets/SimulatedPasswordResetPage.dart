import 'package:flutter/material.dart';
import 'package:grad_project/core/widgets/BackButtonCircle.dart';
import 'package:grad_project/core/widgets/SimulatedVerificationPage.dart';
import 'package:grad_project/core/widgets/VerificationPage.dart';

class SimulatedPasswordResetPage extends StatefulWidget {
  static const String routeName = 'SimulatedPasswordResetPage';

  @override
  _SimulatedPasswordResetPageState createState() => _SimulatedPasswordResetPageState();
}

class _SimulatedPasswordResetPageState extends State<SimulatedPasswordResetPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  void _simulateSendResetCode() {
    final email = _emailController.text.trim();
    final isValidEmail = email.contains('@') && email.contains('.');

    if (!isValidEmail) {
      _showErrorPopup("Please enter a valid email address");
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reset code sent. Check your inbox or spam.'),
          backgroundColor: Color(0xff199A8E),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SimulatedVerificationPage(contactInfo: email),
        ),
      );
    });
  }

  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF199A8E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("Retry", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintText: 'example@gmail.com',
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.email, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _simulateSendResetCode,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff199A8E),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
            : const Text(
          'Send Reset Code',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Forgot Your Password?',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Enter your email and we will simulate sending a reset code.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16, height: 1.4),
                    ),
                  ],
                ),
                Column(
                  children: [
                    _buildEmailField(),
                    const SizedBox(height: 40),
                    _buildResetButton(),
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