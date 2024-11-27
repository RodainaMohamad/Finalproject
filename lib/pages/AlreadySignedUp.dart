import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradproject/core/constants/colours/colours.dart';
import 'package:gradproject/core/widgets/wavyAppBar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../core/constants/strings/strings.dart';
import '../core/widgets/bottomBar.dart';

class Alreadysignedup extends StatefulWidget {
  const Alreadysignedup({super.key});

  @override
  _AlreadysignedupState createState() => _AlreadysignedupState();
}

class _AlreadysignedupState extends State<Alreadysignedup> {
  Color yesBorderColor = secondary;
  Color noBorderColor = secondary;

  void _updateBorder(String button) {
    setState(() {
      if (button == 'Yes') {
        yesBorderColor = primary;
        noBorderColor = secondary;
      } else {
        noBorderColor = primary;
        yesBorderColor = secondary;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationBar;
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
          const Stack(
            children: [
              Wavyappbar(),
            ],
          ),
          const SizedBox(height: 25),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AlreadySignedUp,
                const SizedBox(height: 5),
                Text(
                  'Already Signed Up?',
                  style: GoogleFonts.roboto(
                    fontSize: 55,
                    height: 1.243,
                    fontWeight: FontWeight.w700,
                    color: secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 59,
                      width: 116,
                      child: ElevatedButton(
                        onPressed: () => _updateBorder('Yes'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: textboxColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(width: 2, color: yesBorderColor),
                          ),
                        ),
                        child: Text(
                          'Yes',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: secondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    SizedBox(
                      height: 59,
                      width: 116,
                      child: ElevatedButton(
                        onPressed: () => _updateBorder('No'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: textboxColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(width: 2, color: noBorderColor),
                          ),
                        ),
                        child: Text(
                          'No',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: secondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StepProgressIndicator(
                    totalSteps: 6,
                    currentStep:1,
                    size:10,
                    selectedColor: secondary,
                    unselectedColor: primary,
                  )
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          bottomNavigationBar= const BottomBar(),
        ],
      ),
    );
  }
}