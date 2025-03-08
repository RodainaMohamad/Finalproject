import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/pages/create_account_doctor.dart';
import 'package:grad_project/pages/create_account_patient.dart';

class DoctorPatient extends StatelessWidget {
  const DoctorPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF22E0E4),
              Color(0xFF2C5C5D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondary,
                border: Border.all(
                  color: secondary,
                  width: 2,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/patient.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment(0.0, -0.2),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAccountScreenPatient(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Patient',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      height: 1.172,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: 20,
                  color: secondary,
                ),
                const SizedBox(width: 5),
                Text(
                  'OR',
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    height: 1.172,
                    fontWeight: FontWeight.w400,
                    color: secondary,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  height: 1,
                  width: 20,
                  color: secondary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondary,
                border: Border.all(
                  color: secondary,
                  width: 2,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/doctor.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment(0.0, -0.2),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAccountScreenDoctor(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Doctor',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      height: 1.172,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
