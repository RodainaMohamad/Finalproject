import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/API_integration/models/PatientDetailsModel.dart';
import 'package:grad_project/API_integration/services/PatientDetails_service.dart';
import 'package:grad_project/API_integration/utility.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/AnimatedStatusIndicator.dart';
import 'package:grad_project/core/widgets/HomeBottomBar.dart';
import 'package:grad_project/core/widgets/expansionTile.dart';
import 'package:grad_project/core/widgets/PatientMenu.dart';
import 'package:grad_project/core/widgets/statusCards.dart';
import 'package:grad_project/cubits/HeartRate_events.dart';
import 'package:grad_project/cubits/HeartRate_states.dart';
import 'package:grad_project/cubits/MQTT__Temp_events.dart';
import 'package:grad_project/cubits/MQTT__Temp_states.dart';
import 'package:grad_project/cubits/OxygenRate_events.dart';
import 'package:grad_project/cubits/OxygenRate_states.dart';

class PatientHome extends StatefulWidget {
  static const String routeName = 'PatientHome';
  final String patientName; // Make patientName required

  const PatientHome({Key? key, required this.patientName}) : super(key: key);

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  late Future<void> _loadUserInfoFuture;

  @override
  void initState() {
    super.initState();
    _loadUserInfoFuture = _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final token = await AuthUtils.getToken();
    if (token == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AuthUtils.clearToken();
        Navigator.pushReplacementNamed(context, 'Signin');
      });
      return;
    }
  }

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

    return FutureBuilder(
      future: _loadUserInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
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
            child: Column(
              children: [
                SizedBox(height: height * 0.062),
                Padding(
                  padding: EdgeInsets.all(width * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                                "${widget.patientName}...", // Use patientName from widget
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
                          CircleAvatar(
                            radius: width * 0.07,
                            backgroundImage: const AssetImage("assets/patientAvatar.png"),
                          ),
                          SizedBox(width: width * 0.1),
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
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.4,
                        height: width * 0.4,
                        decoration: BoxDecoration(
                          color: lighterColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Current Status",
                              style: TextStyle(
                                color: secondary,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            AnimatedStatusIndicator(
                              item: StatusItemData(label: "Very Good"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.01),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  BlocBuilder<HeartRateCubit, HeartRateState>(
                                    builder: (context, state) {
                                      return StatusCard(
                                        image: Image.asset("assets/heartRate.png"),
                                        title: "Heart Rate",
                                        value: _getHeartRateValue(state),
                                        unit: "bpm",
                                      );
                                    },
                                  ),
                                  SizedBox(width: width * 0.01),
                                  BlocBuilder<TemperatureCubit, TemperatureState>(
                                    builder: (context, state) {
                                      return StatusCard(
                                        image: Image.asset("assets/temp.png"),
                                        title: "Temperature",
                                        value: _getDisplayValue(state),
                                        unit: "°C",
                                      );
                                    },
                                  ),
                                  SizedBox(width: width * 0.01),
                                  BlocBuilder<OxygenRateCubit, OxygenRateState>(
                                    builder: (context, state) {
                                      return StatusCard(
                                        image: Image.asset("assets/pressure.png"),
                                        unit: "%",
                                        title: "Oxygen",
                                        value: _getOxygenValue(state),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          FutureBuilder<PatientDetailsModel>(
                            future: PatientDetailsService().getPatientDetails(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CustomExpansionTile(title: "My Diagnoses", content: "Loading...");
                              } else if (snapshot.hasError) {
                                final error = snapshot.error.toString();
                                if (error.contains('401')) {
                                  return CustomExpansionTile(
                                    title: "My Diagnoses",
                                    content: "Session expired. Please log in again.",
                                    trailing: IconButton(
                                      icon: const Icon(Icons.login),
                                      onPressed: () {
                                        AuthUtils.clearToken();
                                        Navigator.pushReplacementNamed(context, 'Signin');
                                      },
                                    ),
                                  );
                                }
                                return CustomExpansionTile(
                                  title: "My Diagnoses",
                                  content: error.contains('404') ? "No reports found." : "Error: $error",
                                  trailing: IconButton(
                                    icon: const Icon(Icons.refresh),
                                    onPressed: () => setState(() {}),
                                  ),
                                );
                              } else if (!snapshot.hasData || snapshot.data!.reports == null || snapshot.data!.reports!.isEmpty) {
                                return const CustomExpansionTile(title: "My Diagnoses", content: "No reports found.");
                              } else {
                                final reports = snapshot.data!.reports!;
                                return CustomExpansionTile(
                                  title: "My Diagnoses",
                                  content: reports
                                      .map((report) => "• ${report.reportDetails}\n  Date: ${report.uploadDate?.split('T').first ?? 'Unknown'}")
                                      .join("\n"),
                                );
                              }
                            },
                          ),
                          SizedBox(height: height * 0.03),
                          const CustomExpansionTile(
                            title: "My Medicine",
                            content: "No this time.",
                          ),
                          SizedBox(height: height * 0.057),
                          BottomNavWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getDisplayValue(TemperatureState state) {
    if (!state.isConnected) return "Connecting";
    if (state.error != null) return "Error";
    if (state.temperature == null || state.temperature!.isEmpty) return "--";
    final temp = double.tryParse(state.temperature!) ?? 0;
    return temp.toStringAsFixed(1);
  }

  String _getHeartRateValue(HeartRateState state) {
    if (!state.isConnected) return "Connecting";
    if (state.error != null) return "Error";
    if (state.heartRate == null || state.heartRate!.isEmpty) return "--";
    return state.heartRate!;
  }

  String _getOxygenValue(OxygenRateState state) {
    if (!state.isConnected) return "Connecting";
    if (state.error != null) return "Error";
    if (state.oxygenRate == null) return "--";
    return state.oxygenRate!.toStringAsFixed(1);
  }
}