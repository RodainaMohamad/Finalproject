import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/wavyAppBar.dart';
import 'package:grad_project/pages/PatientHome.dart';
import 'package:grad_project/pages/create_account_patient.dart';
import 'package:grad_project/pages/DoctorPatient.dart';

class Signin extends StatefulWidget {
  static const String routeName = 'Signin';

  const Signin({super.key});

  @override
  _Signin createState() => _Signin();
}

class _Signin extends State<Signin> {
  var email = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> keyLogin = GlobalKey();
  bool flag = false;
  Color yesBorderColor = secondary;
  Color noBorderColor = secondary;

  void _updateBorder(String button) {
    setState(() {
      if (button == 'Login') {
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.17),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Welcome',
                        style: GoogleFonts.nunito(
                          fontSize: 30,
                          height: 1.364,
                          fontWeight: FontWeight.w700,
                          color: secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Divider(
                        indent: 120,
                        endIndent: 120,
                        height: 0,
                        color: secondary,
                        thickness: 0.4,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Login To Your Account',
                        style: GoogleFonts.nunito(
                          fontSize: 10,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          color: secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Form(
                        key: keyLogin,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 50),
                                TextFormField(
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: secondary),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: secondary),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          color: secondary, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          color: textboxColor, width: 1.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    if (text.length < 6 ||
                                        !text.contains('@') ||
                                        !text.endsWith('.com') ||
                                        text.startsWith('@')) {
                                      return 'Invalid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                TextFormField(
                                  controller: password,
                                  keyboardType: TextInputType.text,
                                  obscureText: !flag,
                                  style: TextStyle(color: secondary),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: secondary),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: secondary, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: textboxColor, width: 1.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          flag = !flag;
                                        });
                                      },
                                      icon: Icon(
                                        flag
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: secondary,
                                      ),
                                    ),
                                  ),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return 'Field cannot be null';
                                    }
                                    if (text.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (keyLogin.currentState!.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Patienthome()),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please enter valid information in all fields.',
                                            style: TextStyle(color: primary),
                                          ),
                                          backgroundColor: secondary,
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      side: BorderSide(
                                          width: 2, color: yesBorderColor),
                                    ),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: primary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                height: 50,
                                width: 220,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DoctorPatient()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      side: BorderSide(
                                          width: 2, color: yesBorderColor),
                                    ),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'Don’t have an account',
                                      style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: primary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}