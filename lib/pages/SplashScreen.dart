import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/pages/SignIn.dart';
import '../core/constants/strings/strings.dart';

class Splashscreen extends StatelessWidget {
  static const String routeName = 'Splashscreen';

  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradient1,
              gradient2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.13),
            Center(
              child: nabd,
            ),
            SizedBox(height: screenHeight * 0.051),
            GestureDetector(
              child: arrow,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Signin()),
                );
              },
            ),
            splashImage,
          ],
        ),
      ),
    );
  }
}