import 'package:flutter/material.dart';
import 'package:grad_project/pages/SignIn.dart';
import 'package:grad_project/pages/SplashScreen.dart';
import 'package:grad_project/pages/create_account_patient.dart';
import 'package:grad_project/pages/whoRU.dart';

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
        'Splashscreen': (context) => Splashscreen(),
        'CreateAccountScreen': (context) => CreateAccountScreen(),
        'Signin': (context) => Signin(),
        'DoctorPation': (context) => DoctorPation(),
      },
    );
  }
}