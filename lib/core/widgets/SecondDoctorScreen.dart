import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/models/registerModel.dart';
import 'package:grad_project/API_integration/services/register_service.dart';
import 'package:intl/intl.dart';

class SecondDoctorScreen extends StatefulWidget {
  final VoidCallback onDone;
  final String email;
  final String fullName;
  final String password;
  final String confirmPassword;

  const SecondDoctorScreen({
    super.key,
    required this.onDone,
    required this.email,
    required this.fullName,
    required this.password,
    required this.confirmPassword,
  });

  @override
  State<SecondDoctorScreen> createState() => _SecondDoctorScreenState();
}

class _SecondDoctorScreenState extends State<SecondDoctorScreen> {
  final _formKeySecondScreen = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  String? selectedGender;

  final RegisterService _registerService = RegisterService();

  Future<void> registerUser() async {
    if (_formKeySecondScreen.currentState!.validate()) {
      try {
        final registerModel = RegisterModel(
          fullName: nameController.text.isNotEmpty ? nameController.text : widget.fullName,
          email: widget.email,
          gender: selectedGender ?? 'M',
          dateOfBirth: birthDateController.text,
          nationalId: nationalIdController.text,
          phoneNumber: phoneNumberController.text,
          userType: 'Doctor',
          specialty: specialtyController.text.isEmpty ? null : specialtyController.text,
          password: widget.password,
          confirmPassword: widget.confirmPassword,
        );
        // Debug: Print the JSON payload
        print('Request Body: ${jsonEncode(registerModel.toJson())}');
        RegisterModel response = await _registerService.register(
          fullName: nameController.text.isNotEmpty ? nameController.text : widget.fullName,
          email: widget.email,
          gender: selectedGender ?? 'M',
          dateOfBirth: birthDateController.text,
          nationalId: nationalIdController.text,
          phoneNumber: phoneNumberController.text,
          userType: 'Doctor',
          specialty: specialtyController.text.isEmpty ? null : specialtyController.text,
          password: widget.password,
          confirmPassword: widget.confirmPassword,
        );
        widget.onDone();
      } catch (e) {
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
        color: const Color(0XFF5DC1C3),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Your Account (Doctor)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onTap: () async {
                    DateTime? data = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2100),
                    );
                    if (data != null) {
                      var formatter = DateFormat('yyyy-MM-dd'); // Match Swagger format
                      birthDateController.text = formatter.format(data);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your birthdate';
                    }
                    try {
                      DateTime.parse(value);
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
                    const Text('Gender', style: TextStyle(color: Colors.white, fontSize: 16)),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => setState(() => selectedGender = 'M'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedGender == 'M' ? Colors.teal : Colors.white,
                            foregroundColor: selectedGender == 'M' ? Colors.white : Colors.teal,
                            shape: const CircleBorder(),
                          ),
                          child: const Text('M'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => setState(() => selectedGender = 'F'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedGender == 'F' ? Colors.teal : Colors.white,
                            foregroundColor: selectedGender == 'F' ? Colors.white : Colors.teal,
                            shape: const CircleBorder(),
                          ),
                          child: const Text('F'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nationalIdController,
                  decoration: InputDecoration(
                    labelText: 'National ID',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your National ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: specialtyController,
                  decoration: InputDecoration(
                    labelText: 'Specialty',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your specialty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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