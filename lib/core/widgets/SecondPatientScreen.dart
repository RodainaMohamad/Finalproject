import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/models/registerModel.dart';
import 'package:grad_project/API_integration/services/register_service.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:intl/intl.dart';

class SecondScreen extends StatefulWidget {
  final VoidCallback onDone;
  final String email;
  final String fullName;
  final String password;
  final String confirmPassword;

  const SecondScreen({
    super.key,
    required this.onDone,
    required this.email,
    required this.fullName,
    required this.password,
    required this.confirmPassword,
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formKeySecondScreen = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? selectedGender;

  final RegisterService _registerService = RegisterService();

  Future<void> registerUser() async {
    if (_formKeySecondScreen.currentState!.validate()) {
      try {
        RegisterModel response = await _registerService.register(
          fullName: nameController.text.isNotEmpty
              ? nameController.text
              : widget.fullName,
          email: widget.email,
          gender: selectedGender ?? 'M',
          dateOfBirth: birthDateController.text,
          nationalId: nationalIdController.text,
          phoneNumber: phoneNumberController.text,
          userType: 'patient',
          password: widget.password,
          confirmPassword: widget.confirmPassword,
          specialty: ""
        );

        widget.onDone();
      } catch (e) {
        debugPrint('Failed to register: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeySecondScreen,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF22E0E4),
              Color(0xFF2C5C5D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Your Account (Patient)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: secondary,
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: secondary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: birthDateController,
                  decoration: InputDecoration(
                    labelText: 'Birth Date',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: secondary,
                  ),
                  onTap: () async {
                    DateTime? data = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (data != null) {
                      var formatter =
                          DateFormat('yyyy-MM-dd'); // Use ISO 8601 format.
                      birthDateController.text = formatter.format(data);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your birthdate';
                    }
                    try {
                      DateTime.parse(value); // Validate date format.
                    } catch (e) {
                      return 'Invalid date format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Gender',
                        style: TextStyle(color: secondary, fontSize: 16)),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => setState(() => selectedGender = 'M'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedGender == 'M'
                                ? Colors.teal
                                : secondary,
                            foregroundColor: selectedGender == 'M'
                                ? secondary
                                : Colors.teal,
                            shape: const CircleBorder(),
                          ),
                          child: const Text('M'),
                        ),
                        const SizedBox(width: 10),
                        // Button for selecting Female.
                        ElevatedButton(
                          onPressed: () => setState(() => selectedGender = 'F'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedGender == 'F'
                                ? Colors.teal
                                : secondary,
                            foregroundColor: selectedGender == 'F'
                                ? secondary
                                : Colors.teal,
                            shape: const CircleBorder(),
                          ),
                          child: const Text('F'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Text field for National ID.
                TextFormField(
                  controller: nationalIdController,
                  decoration: InputDecoration(
                    labelText: 'National ID',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: secondary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your National ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Text field for Phone Number.
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: secondary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Button to submit the form.
                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondary,
                    foregroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
