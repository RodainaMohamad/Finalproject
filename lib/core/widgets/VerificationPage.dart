import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/services/ResetPassword_service.dart';
import 'package:pinput/pinput.dart';
import 'package:grad_project/API_integration/models/ResetPasswordModel.dart';
import 'BackButtonCircle.dart';
import 'CreateNewPasswordPage.dart';

class VerificationPage extends StatefulWidget {
  final String contactInfo;

  const VerificationPage({Key? key, required this.contactInfo}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController pinController = TextEditingController();
  final ResetPasswordService _resetPasswordService = ResetPasswordService();
  bool _isLoading = false;

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

  Future<void> _verifyCode() async {
    final code = pinController.text.trim();
    if (code.isEmpty || code.length != 4) {
      _showError('Please enter a valid 4-digit code');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Temporary model to verify the code (assuming CreateNewPasswordPage handles password)
      final model = ResetPasswordModel(
        email: widget.contactInfo,
        resetCode: code,
        newPassword: null, // Password will be set in CreateNewPasswordPage
      );
      final success = await _resetPasswordService.resetPassword(model);
      print('ResetPassword API call: Email=${model.email}, Code=$code, Success=$success');
      if (success) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewPasswordPage(email: widget.contactInfo, resetCode: code),
            ),
          );
        }
      } else {
        _showError('Failed to verify code. Please check the code and try again.');
      }
    } catch (e) {
      print('ResetPassword error: $e');
      _showError('Error: ${e.toString().replaceFirst('Exception: ', '')}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final success = await _resetPasswordService.resendConfirmationEmail(widget.contactInfo);
      print('ResendConfirmationEmail API call: Email=${widget.contactInfo}, Success=$success');
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('New code sent to your email. Please check your inbox or spam folder.'),
              backgroundColor: Color(0xFF199A8E),
              duration: Duration(seconds: 4),
            ),
          );
        }
      } else {
        _showError('Failed to resend code. Please try again or contact support.');
      }
    } catch (e) {
      print('ResendConfirmationEmail error: $e');
      _showError('Error: ${e.toString().replaceFirst('Exception: ', '')}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 40,
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Retry',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                      'Email verification',
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
                        color: Colors.black87,
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
                        onPressed: _isLoading ? null : _verifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF199A8E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
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
                      onPressed: _isLoading ? null : _resendCode,
                      child: const Text(
                        'Resend code',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
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