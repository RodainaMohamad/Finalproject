import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/API_integration/services/PatientByName_service.dart';
import 'package:grad_project/API_integration/services/login_service.dart';
import 'package:grad_project/API_integration/utility.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/pages/DoctorPatient.dart';

class Signin extends StatefulWidget {
  static const String routeName = 'Signin';
  const Signin({super.key});
  @override
  _Signin createState() => _Signin();
}

class _Signin extends State<Signin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool showPassword = false;
  bool isLoading = false;
  Color yesBorderColor = secondary;
  Color noBorderColor = secondary;

  final LoginService _loginService = LoginService();
  final PatientByNameService _patientByNameService = PatientByNameService();

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

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setState(() => isLoading = true);

    try {
      // Clear previous patient ID
      await AuthUtils.clearPatientId();
      print('DEBUG: Cleared previous patient ID');

      // Perform login
      final Map<String, dynamic> loginResponse = await _loginService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      debugPrint('DEBUG: Login successful. Raw loginResponse: $loginResponse');

      if (loginResponse['accessToken'] != null) {
        // Save token and refresh token
        await AuthUtils.saveToken(loginResponse['accessToken']);
        await AuthUtils.saveRefreshToken(loginResponse['refreshToken']);

        // Save patient name (e.g., "asad" from "asad123@gmail.com")
        final email = emailController.text.trim();
        // Strip numbers to match API's letters-only name (e.g., "asad123" -> "asad")
        final userName = email.split('@')[0].replaceAll(RegExp(r'\d+'), '');
        await AuthUtils.savePatientName(userName);
        print('DEBUG: Saved patient name: $userName');

        // Attempt to fetch and save patient ID
        try {
          final patientId = await _patientByNameService.getPatientIdByName(userName);
          if (patientId != null) {
            await AuthUtils.savePatientId(patientId);
            print('DEBUG: Saved patient ID: $patientId');
          } else {
            print('DEBUG: No patient ID found for $userName');
          }
        } catch (e) {
          print('DEBUG: Failed to fetch patient ID for $userName: $e');
        }

        final userType = loginResponse['userType'] ?? 'Patient';

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Login successful! Welcome $userName',
                style: TextStyle(color: primary),
              ),
              backgroundColor: secondary,
              duration: const Duration(seconds: 3),
            ),
          );

          if (userType == 'Doctor') {
            Navigator.pushReplacementNamed(
              context,
              'DoctortHome',
              arguments: {'doctorName': userName},
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              'PatientHome',
              arguments: {'patientName': userName},
            );
          }
        }
      } else {
        throw Exception('No access token received from API');
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceFirst('Exception: ', '');
        if (errorMessage.contains('400')) {
          errorMessage = 'Invalid email or password.';
        }
        debugPrint('Login error: $errorMessage');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login failed: $errorMessage',
              style: TextStyle(color: primary),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradient1, gradient2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.17),
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
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 50),
                              TextFormField(
                                controller: emailController,
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
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: !showPassword,
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
                                    icon: Icon(
                                      showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: secondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return 'Field cannot be empty';
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 2, color: yesBorderColor),
                                    ),
                                  ),
                                  child: isLoading
                                      ? CircularProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                        primary),
                                  )
                                      : Text(
                                    'Login',
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: primary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: 220,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const DoctorPatient(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 2, color: yesBorderColor),
                                    ),
                                  ),
                                  child: Text(
                                    'Do not have an account',
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: primary,
                                    ),
                                    textAlign: TextAlign.center,
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