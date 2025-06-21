import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/services/ResetPassword_service.dart';
import '../core/widgets/BackButtonCircle.dart';
import '../core/widgets/VerificationPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = 'ForgotPasswordPage';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final ResetPasswordService _resetPasswordService = ResetPasswordService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF22E0E4), Color(0xFF2C5C5D)],
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
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Enter your email address, and we will send you a confirmation code to reset your password. Please check your spam/junk folder if you don\'t see the email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        height: 1.4,
                      ),
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
        onPressed: _isLoading ? null : _resetPassword,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff199A8E),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : const Text(
          'Send Reset Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _showErrorPopup("Please enter a valid email address");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await _resetPasswordService.forgotPassword(email);
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reset code sent to your email. Please check your inbox or spam folder.'),
              backgroundColor: Color(0xff199A8E),
              duration: Duration(seconds: 5),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationPage(contactInfo: email),
            ),
          );
        }
      } else {
        _showErrorPopup("Failed to send reset code. Please try again or contact support.");
      }
    } catch (e) {
      _showErrorPopup("Error: ${e.toString().replaceFirst('Exception: ', '')}");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendCode() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _showErrorPopup("Please enter a valid email address");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await _resetPasswordService.resendConfirmationEmail(email);
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reset code resent to your email. Please check your inbox or spam folder.'),
              backgroundColor: Color(0xff199A8E),
              duration: Duration(seconds: 5),
            ),
          );
        }
      } else {
        _showErrorPopup("Failed to resend reset code. Please try again or contact support.");
      }
    } catch (e) {
      _showErrorPopup("Error: ${e.toString().replaceFirst('Exception: ', '')}");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 24),
            const Text(
              "Failed",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF199A8E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 3,
                ),
                child: const Text(
                  "Retry",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            if (message.contains("Failed to send reset code"))
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resendCode();
                },
                child: const Text(
                  "Resend Code",
                  style: TextStyle(
                    color: Color(0xFF199A8E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}