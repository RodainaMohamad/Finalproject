import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/bottomBar.dart';
import 'package:grad_project/core/widgets/wavyAppBar.dart';
import 'package:grad_project/pages/create_account_patient.dart';

class DoctorPation extends StatelessWidget {
  const DoctorPation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      //////////////////////////////////////
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Wavyappbar(),
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
/////////////////////////////////////////////////////////////
          // المسافة بين الدائرة الأولى والزر
          const SizedBox(height: 30),

          Align(
            alignment: const Alignment(0.0, -0.2),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => CreateAccountScreen()));},
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
//////////////////////////////////////////////////////////
          // المسافة بين الزر والنص "OR"
          const SizedBox(height: 26),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 20,
                color: secondary,
              ),
              const SizedBox(width:5),
              Text(
                'OR',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  height: 1.172,
                  fontWeight: FontWeight.w400,
                  color: secondary,
                ),
              ),
              const SizedBox(width:5),
              Container(
                height: 1,
                width: 20,
                color: secondary,
              ),
            ],
          ),
/////////////////////////////////////////////////////////
          // المسافة بين النص "OR" والدائرة الثانية
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

          // المسافة بين الدائرة الثانية والزر الثاني
          const SizedBox(height: 20),

          // الزر الثاني "Doctor"
          Align(
            alignment: const Alignment(0.0, -0.2),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {},
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
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(),
          ),
        ],
      ),
    );
  }
}