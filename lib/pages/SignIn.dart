import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradproject/core/constants/colours/colours.dart';
import 'package:gradproject/core/widgets/wavyAppBar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../core/widgets/bottomBar.dart';

class Signin extends StatefulWidget {
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
                const SizedBox(height:5),
                Divider(
                  indent: 120,
                  endIndent: 120,
                  height:0,
                  color: secondary,
                  thickness: 0.4,
                ),
                const SizedBox(height:10),
                Text(
                  'Login To Your Account',
                  style: GoogleFonts.nunito(
                    fontSize:10,
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height:50),
                            TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: secondary), // Text color when typing
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: secondary), // Label color
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color: secondary, width: 2.0), // Border turns secondary if presssed
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color:textboxColor, width: 1.5), // borderColour
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
                              style: TextStyle(color: secondary), // Text color
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: secondary), // Label color
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: secondary, width: 2.0), // Border color if pressed
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color:textboxColor, width: 1.5), //borderColor
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
                                    flag ? Icons.visibility : Icons.visibility_off,
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
                            Positioned(
                              bottom: -25, // Positioned below the TextFormField
                              left: 10,   // Aligned to the bottom-right corner
                              child: GestureDetector(
                                onTap: () {}, //forget password action
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: secondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height:30),
                          ],
                        ),
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
                            onPressed: () => _updateBorder('Login'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(width: 2, color: yesBorderColor),
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
                        const SizedBox(width:5),
                        SizedBox(
                          height: 50,
                          width: 220,
                          child: ElevatedButton(
                            onPressed: () => _updateBorder('Don’t have an account'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(width: 2, color: yesBorderColor),
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
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          const SizedBox(height:58),
          bottomNavigationBar = const BottomBar(),
        ],
      ),
    );
  }
}