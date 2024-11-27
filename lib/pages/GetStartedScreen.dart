import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradproject/core/constants/colours/colours.dart';
import 'package:gradproject/pages/AlreadySignedUp.dart';
import '../core/constants/strings/strings.dart';

class Getstartedscreen extends StatefulWidget {
  const Getstartedscreen({super.key});

  @override
  State<Getstartedscreen> createState() => _GetstartedscreenState();
}

class _GetstartedscreenState extends State<Getstartedscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: -35,
            child: topRightCorner,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Centers the content vertically
              children: [
                getStarted,
                const SizedBox(height: 20),
                SizedBox(
                  width: 346,
                  height: 77,
                  child: ElevatedButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Alreadysignedup()));},
                    style:ElevatedButton.styleFrom(
                        backgroundColor: textboxColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side:BorderSide(width:4,color: secondary)
                        )),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}