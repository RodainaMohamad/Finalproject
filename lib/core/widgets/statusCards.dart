import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/constants/colours/colours.dart';

class StatusCard extends StatelessWidget {
  final Image image;
  final String title;
  final String value;
  final String unit;
  // final String normalRange;

  StatusCard({
    super.key,
    required this.image,
    required this.title,
    required this.value,
    required this.unit,
    // required this.normalRange,
  });
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height; // Corrected height

    return Row(
      children: [
        Container(
          width: width * 0.38,
          height: height * 0.19,
          decoration: BoxDecoration(
            color: lighterColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  image,
                  SizedBox(width: width * 0.01),
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: secondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: width * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.nunito(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: secondary,
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                  Text(
                    unit,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}