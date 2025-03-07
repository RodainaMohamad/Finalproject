import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grad_project/core/widgets/SecondDoctorScreen.dart';
import 'package:grad_project/core/widgets/first_screen.dart';
import 'package:grad_project/core/widgets/thank_you.dart';

class CreateAccountScreenDoctor extends StatefulWidget {
  static const String routeName = 'CreateAccountScreenDoctor';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreenDoctor> {
  int currentIndex = 0;
  bool showThankYou = false;
  String? email;
  String? fullName;
  String? password;
  String? confirmPassword;

  void navigateToSecondScreen(String email, String fullName, String password, String confirmPassword) {
    setState(() {
      this.email = email;
      this.fullName = fullName;
      this.password = password;
      this.confirmPassword = confirmPassword;
      currentIndex = 1;
    });
  }

  void showThankYouScreen() {
    setState(() {
      showThankYou = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF5DC1C3),
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipperOne(flip: true),
            child: Container(
              height: 120,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: showThankYou
                ? const ThankYou()
                : IndexedStack(
              index: currentIndex,
              children: [
                FirstScreen(onContinue: navigateToSecondScreen),
                SecondDoctorScreen(
                  onDone: showThankYouScreen,
                  email: email ?? '',
                  fullName: fullName ?? '',
                  password: password ?? '',
                  confirmPassword: confirmPassword ?? '',
                ),
              ],
            ),
          ),
          if (!showThankYou)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    height: 8.0,
                    width: currentIndex == index ? 16.0 : 8.0,
                    decoration: BoxDecoration(
                      color: currentIndex == index ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  );
                }),
              ),
            ),
          ClipPath(
            clipper: WaveClipperTwo(reverse: true),
            child: Container(
              height: 100,
              color: Colors.white,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (currentIndex > 0 && !showThankYou) {
                        setState(() {
                          currentIndex = 0;
                        });
                      }
                    },
                    backgroundColor: const Color(0XFF5DC1C3),
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}