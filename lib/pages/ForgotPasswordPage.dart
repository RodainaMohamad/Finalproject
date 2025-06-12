import 'package:flutter/material.dart';
import '../core/widgets/BackButtonCircle.dart';
import '../core/widgets/VerificationPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = 'ForgotPasswordPage';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _isEmailSelected = true;
  String _selectedCountryCode = '+20';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final List<String> _countryCodes = ['+20', '+966', '+971', '+973'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                      'Enter your email or your phone number, we will send you confirmation code',
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
                    _buildToggleButtons(),
                    const SizedBox(height: 30),
                    _isEmailSelected ? _buildEmailField() : _buildPhoneField(),
                    const SizedBox(height: 40),
                    _buildResetButton(),
                  ],
                ),
                BackButtonCircle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildToggleButton('Email', 0),
          _buildToggleButton('Phone', 1),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, int index) {
    bool isSelected = _isEmailSelected == (index == 0);
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isEmailSelected = index == 0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Color(0xff199A8E) : Colors.white,
                fontWeight: FontWeight.w600,
              ),
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

  Widget _buildPhoneField() {
    return Row(
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            dropdownColor: Color(0xff2C5C5D),
            value: _selectedCountryCode,
            items: _countryCodes
                .map((value) => DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _selectedCountryCode = value!),
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              hintText: '100 183 66 82',
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.phone, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _resetPassword,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff199A8E),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Reset Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _resetPassword() {
    if (_isEmailSelected) {
      final email = _emailController.text.trim();
      if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
        _showErrorPopup("You have entered wrong email");
        return;
      }
    } else {
      final phone = _phoneController.text.trim();
      if (phone.isEmpty || phone.length < 8) {
        _showErrorPopup("You have entered wrong phone number");
        return;
      }
    }

    final contactInfo = _isEmailSelected
        ? _emailController.text
        : '$_selectedCountryCode${_phoneController.text}';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationPage(contactInfo: contactInfo),
      ),
    );

    // هنا تقدر تضيف التنقل إلى صفحة التحقق
    // Navigator.push(...);
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
            )
          ],
        ),
      ),
    );
  }
}
