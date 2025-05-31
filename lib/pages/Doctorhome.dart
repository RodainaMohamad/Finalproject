import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/DoctorMenu.dart';
import 'package:grad_project/core/widgets/HomeBottomBar.dart';
import 'package:grad_project/core/widgets/patienScrean.dart';
import 'package:grad_project/core/widgets/patientSection.dart';
import 'package:grad_project/core/widgets/patientstatus.dart';
import 'package:grad_project/core/widgets/staffcection.dart';
import 'package:grad_project/core/widgets/staffscrean.dart';

class Doctorhome extends StatelessWidget {
  static const String routeName = 'DoctortHome';
  final String doctorName;

  const Doctorhome({super.key, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final icons = [
      Icons.menu_rounded,
      Icons.notifications_none_rounded,
    ];
    final routes = [
      '/menu',
      '/notifications',
    ];
    bool hasNotification = true;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradient1,
              gradient2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.062),
              Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Logo + divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: secondary,
                            thickness: 0.5,
                            indent: width * 0.3,
                            endIndent: width * 0.02,
                          ),
                        ),
                        Image.asset(
                          "assets/nabdLogo.png",
                          width: width * 0.2,
                          height: height * 0.07,
                        ),
                        Expanded(
                          child: Divider(
                            color: secondary,
                            thickness: 0.5,
                            indent: width * 0.02,
                            endIndent: width * 0.3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.001),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text section (Welcome, Doctor Name)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Welcome",
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                height: 1.4,
                                fontWeight: FontWeight.w700,
                                color: secondary,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              "Dr/${doctorName.isEmpty ? 'Unknown' : doctorName} ...", // Dynamic name
                              style: GoogleFonts.nunito(
                                fontSize: 10,
                                height: 1.4,
                                fontWeight: FontWeight.w700,
                                color: secondary,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        SizedBox(width: width * 0.02),
                        // CircleAvatar (center)
                        CircleAvatar(
                          radius: width * 0.07,
                          backgroundImage:
                          const AssetImage("assets/patientAvatar.png"),
                        ),
                        SizedBox(width: width * 0.1),
                        // Icons section
                        Row(
                          children: List.generate(
                            icons.length,
                                (index) => GestureDetector(
                              onTap: () {
                                if (index == 0) {
                                  showMenuDialog(context);
                                } else {
                                  Navigator.pushNamed(context, routes[index]);
                                }
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(width * 0.02),
                                    child: Container(
                                      width: width * 0.09,
                                      height: width * 0.12,
                                      decoration: BoxDecoration(
                                        color: secondary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        icons[index],
                                        size: width * 0.06,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                  if (index == 1 && hasNotification)
                                    Positioned(
                                      bottom: width * 0.02,
                                      right: width * 0.02,
                                      child: Container(
                                        width: width * 0.04,
                                        height: width * 0.04,
                                        decoration: BoxDecoration(
                                          color: notifications,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(height: 358, child: PatientStatusPage()),
              const SizedBox(height: 10),
              PatientSection(
                onTap: () => _showCustomScreenDialog(context, 'patients'),
              ),
              const SizedBox(height: 10),
              StaffSection(
                onTap: () => _showCustomScreenDialog(context, 'staff'),
              ),
              SizedBox(height: height * 0.021),
              BottomNavWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomScreenDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(16),
                    ),
                    child: _buildCustomScreenContent(type),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomScreenContent(String type) {
    switch (type) {
      case 'patients':
        return const PatientsScreen();
      case 'staff':
        return const StaffScreen();
      default:
        return const Center(child: Text('Invalid screen type'));
    }
  }
}