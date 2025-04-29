import 'package:flutter/material.dart';
import 'package:grad_project/pages/DoctorPatient.dart';
import 'package:grad_project/pages/PatientHome.dart';
import 'package:grad_project/pages/SignIn.dart';
import 'package:grad_project/pages/SplashScreen.dart';
import 'package:grad_project/pages/create_account_doctor.dart';
import 'package:grad_project/pages/create_account_patient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "Splashscreen",
      routes: {
        'Splashscreen': (context) => const Splashscreen(),
        'CreateAccountScreenPatient': (context) => CreateAccountScreenPatient(),
        'Signin': (context) => const Signin(),
        'DoctorPatient': (context) => const DoctorPatient(),
        'PatientHome': (context) => const Patienthome(),
        'CreateAccountScreenDoctor': (context) => CreateAccountScreenDoctor(),
        'DoctortHome': (context) => const Patienthome(),
      },
    );
  }
}
