import 'package:flutter/material.dart';
import 'package:grad_project/core/constants/colours/colours.dart';

class PatientSection extends StatelessWidget {
  final VoidCallback onTap;

  const PatientSection({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 2555, 0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: secondary,
              width: .6,  
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Patients',
                style: TextStyle(
                  color: secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: secondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_drop_down,
                  size: 35,
                  color: Color(0xff2C999B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}