import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SecondScreen extends StatefulWidget {
  final VoidCallback onDone;

  const SecondScreen({super.key, required this.onDone});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _isObscure = true;
  final _formKeySecondScreen = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController nationalidController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController specialistcontroller = TextEditingController();

  void showThankYouScreen() {
    if (_formKeySecondScreen.currentState!.validate()) {
      widget.onDone(); // Call the callback function
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Create Your Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      final regex = RegExp(r'^[\u0600-\u06FFa-zA-Z\s]+$');
                      if (!regex.hasMatch(value)) {
                        return 'Please enter letters Arabic and English';
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onTap: () async {
                      DateTime data = DateTime(1900);
                      FocusScope.of(context).requestFocus(FocusNode());
                      data = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ))!;
                      String dateFormatter = data.toIso8601String();
                      DateTime dt = DateTime.parse(dateFormatter);
                      var formatter = DateFormat('dd-MMMM-yyyy');
                      birthDateController.text = formatter.format(dt);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your birthdate';
                      }
                      DateTime birthDate = DateFormat('dd-MMMM-yyyy').parse(value);
                      int age = DateTime.now().year - birthDate.year;
                      if (DateTime.now().month < birthDate.month ||
                          (DateTime.now().month == birthDate.month &&
                              DateTime.now().day < birthDate.day)) {
                        age--;
                      }
                      if (age < 18) {
                        return 'Age must be greater than 18';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.teal,
                              shape: const CircleBorder(),
                            ),
                            child: const Text('M'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.teal,
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
                    controller: nationalidController,
                    decoration: InputDecoration(
                      labelText: 'National ID',
                      labelStyle: const TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your National ID';
                      }
                      if (value.length != 14) {
                        return 'National ID must be 14 digits';
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the phone number';
                      }
                      if (value.length != 11) {
                        return 'The phone number must contain 11 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: specialistcontroller,
                    decoration: InputDecoration(
                      labelText: 'Specialist',
                      labelStyle: const TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the specialist';
                      }
                      final regex = RegExp(r'^[\u0600-\u06FFa-zA-Z\s]+$');
                      if (!regex.hasMatch(value)) {
                        return 'Please enter letters Arabic and English';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: showThankYouScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
      ),
    );
  }
}