import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/HomeBottomBar.dart';
import 'package:grad_project/core/widgets/expansionTile.dart';
import 'package:grad_project/core/widgets/statusCards.dart';

class Patienthome extends StatelessWidget {
  static const String routeName = 'PatientHome';
  const Patienthome({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final icons = [
      Icons.message_rounded,
      Icons.menu_rounded,
      Icons.notifications_none_rounded,
    ];
    final routes = [
      '/messages',
      '/menu',
      '/notifications',
    ];
    bool hasNotification = true;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
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
          child: Column(
            children: [
              SizedBox(height: height * 0.062),
              Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/nabdLogo.png",
                      width: width * 0.2,
                      height: height * 0.07,
                    ),
                    SizedBox(width: width * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        icons.length,
                        (index) => GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, routes[index]),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: Container(
                                  width: width * 0.15,
                                  height: width * 0.15,
                                  decoration: BoxDecoration(
                                    color: secondary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    icons[index],
                                    size: width * 0.08,
                                    color: primary,
                                  ),
                                ),
                              ),
                              if (index == 2 && hasNotification)
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
                    SizedBox(width: width * 0.02),
                    CircleAvatar(
                      radius: width * 0.07,
                      backgroundImage:
                          const AssetImage("assets/patientAvatar.png"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: GoogleFonts.nunito(
                              fontSize: 30,
                              height: 1.4,
                              fontWeight: FontWeight.w700,
                              color: secondary,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: height * 0.002),
                          Divider(
                            color: secondary,
                            thickness: 1.5,
                            indent: width * 0.0,
                            endIndent: width * 0.15,
                          ),
                          SizedBox(height: height * 0.002),
                          Text(
                            "Mohamed Ahmed",
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              height: 1.4,
                              fontWeight: FontWeight.w700,
                              color: secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: BoxDecoration(
                        color: lighterColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 125,
                                  height: 125,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [Colors.green, Colors.yellow],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 92,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: secondary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Very Good",
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatusCard(
                        image: Image.asset("assets/heartRate.png"),
                        title: "Heart Rate",
                        value: "88",
                        unit: "bpm",
                      ),
                      SizedBox(width: width * 0.01),
                      StatusCard(
                        image: Image.asset("assets/temp.png"),
                        title: "Temperature",
                        value: "37.6",
                        unit: "°C",
                      ),
                      SizedBox(width: width * 0.01),
                      StatusCard(
                        image: Image.asset("assets/pressure.png"),
                        title: "Oxygen",
                        value: "96",
                        unit: "%",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              const CustomExpansionTile(
                title: "My Diagnoses",
                content:
                    "Neu  Heart hear stress Palpitat\n.\"\" It is recommended to jyjtyjt  but jgk tyjtdfx perform an ECG and thyroid function tests to confirm the diagnosis and rule out organic causes.",
              ),
              SizedBox(height: height * 0.03),
              const CustomExpansionTile(
                  title: "My Medicine", content: "No this time."),
              SizedBox(height: height * 0.021),
              BottomNavWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
