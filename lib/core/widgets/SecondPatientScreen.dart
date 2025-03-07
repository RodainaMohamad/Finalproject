// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class SecondPatientScreen extends StatefulWidget {
//   final VoidCallback onDone;
//
//   const SecondPatientScreen({super.key, required this.onDone});
//
//   @override
//   State<SecondPatientScreen> createState() => _SecondScreenState();
// }
//
// class _SecondScreenState extends State<SecondPatientScreen> {
//   bool _isObscure = true;
//   final _formKeySecondScreen = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController birthDateController = TextEditingController();
//   final TextEditingController nationalidController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController specialistcontroller = TextEditingController();
//
//   void showThankYouScreen() {
//     if (_formKeySecondScreen.currentState!.validate()) {
//       widget.onDone(); // Call the callback function
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKeySecondScreen,
//       child: Container(
//         color: const Color(0XFF5DC1C3),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Text(
//                     'Create Your Account',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       labelText: 'Name',
//                       labelStyle: const TextStyle(color: Colors.teal),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter the name';
//                       }
//                       final regex = RegExp(r'^[\u0600-\u06FFa-zA-Z\s]+$');
//                       if (!regex.hasMatch(value)) {
//                         return 'Please enter letters Arabic and English';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: birthDateController,
//                     decoration: InputDecoration(
//                       labelText: 'Birth Date',
//                       labelStyle: const TextStyle(color: Colors.teal),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     onTap: () async {
//                       DateTime data = DateTime(1900);
//                       FocusScope.of(context).requestFocus(FocusNode());
//                       data = (await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(1900),
//                         lastDate: DateTime(2100),
//                       ))!;
//                       String dateFormatter = data.toIso8601String();
//                       DateTime dt = DateTime.parse(dateFormatter);
//                       var formatter = DateFormat('dd-MMMM-yyyy');
//                       birthDateController.text = formatter.format(dt);
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select your birthdate';
//                       }
//                       DateTime birthDate = DateFormat('dd-MMMM-yyyy').parse(value);
//                       int age = DateTime.now().year - birthDate.year;
//                       if (DateTime.now().month < birthDate.month ||
//                           (DateTime.now().month == birthDate.month &&
//                               DateTime.now().day < birthDate.day)) {
//                         age--;
//                       }
//                       if (age < 18) {
//                         return 'Age must be greater than 18';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Gender',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.teal,
//                               shape: const CircleBorder(),
//                             ),
//                             child: const Text('M'),
//                           ),
//                           const SizedBox(width: 10),
//                           ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.teal,
//                               shape: const CircleBorder(),
//                             ),
//                             child: const Text('F'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: nationalidController,
//                     decoration: InputDecoration(
//                       labelText: 'National ID',
//                       labelStyle: const TextStyle(color: Colors.teal),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your National ID';
//                       }
//                       if (value.length != 14) {
//                         return 'National ID must be 14 digits';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: phoneNumberController,
//                     decoration: InputDecoration(
//                       labelText: 'Phone Number',
//                       labelStyle: const TextStyle(color: Colors.teal),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter the phone number';
//                       }
//                       if (value.length != 11) {
//                         return 'The phone number must contain 11 digits';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: showThankYouScreen,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.teal,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                     ),
//                     child: const Text(
//                       'Done',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/models/registerModel.dart';
import 'package:grad_project/API_integration/services/register_service.dart';
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
          fullName: nameController.text.isNotEmpty ? nameController.text : widget.fullName,
          email: widget.email,
          gender: selectedGender ?? 'M',
          dateOfBirth: birthDateController.text,
          nationalId: nationalIdController.text,
          phoneNumber: phoneNumberController.text,
          userType: 'patient',
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
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (data != null) {
                      var formatter = DateFormat('yyyy-MM-dd'); // Use ISO 8601 date format
                      birthDateController.text = formatter.format(data);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your birthdate';
                    }
                    try {
                      DateTime.parse(value); // Validate the date format
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