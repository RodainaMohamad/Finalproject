import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/services/AddGuardian_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddGuardianScreen extends StatefulWidget {

  const AddGuardianScreen({Key? key}) : super(key: key);

  @override
  _AddGuardianScreenState createState() => _AddGuardianScreenState();
}

class _AddGuardianScreenState extends State<AddGuardianScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _patientSSNController = TextEditingController();

  // Animation
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Services
  final AddGuardianService _guardianService = AddGuardianService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // State
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _relationshipController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _patientSSNController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    // Simple email validation for format user123@example.com
    return RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+$').hasMatch(email);
  }

  String _cleanPhoneNumber(String phone) {
    // Remove all non-digit characters
    return phone.replaceAll(RegExp(r'[^0-9]'), '');
  }

  Future<String?> _getToken() async {
    try {
      return await _storage.read(key: 'auth_token');
    } catch (e) {
      print('Error reading token: $e');
      return null;
    }
  }

  Future<void> _submitForm() async {
    final name = _nameController.text.trim();
    final relationship = _relationshipController.text.trim();
    final email = _emailController.text.trim();
    final phone = _cleanPhoneNumber(_phoneController.text.trim());
    final patientSSN = _patientSSNController.text.trim();

    // Validate all required fields
    if (name.isEmpty || relationship.isEmpty || phone.isEmpty || email.isEmpty || patientSSN.isEmpty) {
      _showErrorDialog('All fields are required');
      return;
    }

    // Validate email format
    if (!_validateEmail(email)) {
      _showErrorDialog('Please enter a valid email (user123@example.com)');
      return;
    }

    // Validate phone number length
    if (phone.length < 10) {
      _showErrorDialog('Phone number must be at least 10 digits');
      return;
    }

    if (patientSSN.length < 13) {
      _showErrorDialog('Patient SSN more than 13 digits');
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await _getToken();
      if (token == null) throw Exception('Authentication required');

      await _guardianService.addGuardian(
        name: name,
        relationship: relationship,
        phoneNumber: phone,
        email: email,
        patientSSN: patientSSN,
        token: token,
      );

      _showSuccessDialog();
    } catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (errorMessage.contains('400')) {
        errorMessage = 'Invalid data. Please check all fields.';
      } else if (errorMessage.contains('Unauthorized')) {
        await _storage.deleteAll();
        errorMessage = 'Session expired. Please log in again.';
      }
      _showErrorDialog(errorMessage);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessDialog() {
    _animationController.forward(from: 0);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF2C999B),
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Success',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'You have successfully added a new Guardian',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2C999B),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showErrorDialog(String message) {
    _animationController.forward(from: 0);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Failed',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message.length > 100 ? '${message.substring(0, 100)}...' : message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2C999B),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
      backgroundColor: const Color(0xff2C999B),
      body: SingleChildScrollView( // Add this wrapper
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff2C999B),
                borderRadius: BorderRadius.circular(53),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add New Guardian',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Relationship',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _relationshipController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'user123@example.com',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Phone no.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'patient SSN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _patientSSNController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Add Guardian',
                        style: TextStyle(
                          color: Color(0xff2C999B),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add extra space at bottom
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}