import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/wavyAppBar.dart';
import 'package:grad_project/pages/SignIn.dart';
import '../core/constants/strings/strings.dart';

class Splashscreen extends StatelessWidget {

  static const String routeName = 'Splashscreen';

  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
          const Stack(children: [
            Wavyappbar(),
          ]),
          const SizedBox(height:12.5),
          Center(
            child: nabd,
          ),
          const SizedBox(height: 5),
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
    );
  }
}