import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/API_integration/models/GetReportModel.dart';
import 'package:grad_project/API_integration/models/PatientByIdModel.dart';
import 'package:grad_project/API_integration/services/GetReport_service.dart';
import 'package:grad_project/API_integration/services/PatientByIdService.dart';
import 'package:grad_project/API_integration/services/PatientByName_service.dart';
import 'package:grad_project/API_integration/services/VitalData_service.dart';
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
import 'dart:async';

import 'package:grad_project/pages/QRScanner.dart';

class PatientHome extends StatefulWidget {
  static const String routeName = 'PatientHome';
  final String patientName;

  const PatientHome({Key? key, required this.patientName}) : super(key: key);

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  late Future<void> _loadUserInfoFuture;
  int? _patientId;
  PatientByIdModel? _patientDetails;
  bool hasNotification = false; // Initialize as false
  Timer? _notificationTimer; // For periodic checks

  @override
  void initState() {
    super.initState();
    _loadUserInfoFuture = _loadUserInfo();
    _checkForNotifications(); // Initial check
    // Periodically check for new notifications every 30 seconds
    _notificationTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      _checkForNotifications();
    });
  }

  @override
  void dispose() {
    _notificationTimer?.cancel(); // Clean up timer
    super.dispose();
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
    _patientId = await AuthUtils.getPatientId();
    if (_patientId == null) {
      try {
        final name = await AuthUtils.getPatientName();
        if (name == null) {
          throw Exception('No patient name found in storage');
        }
        final patientId = await PatientByNameService().getPatientIdByName(name);
        if (patientId == null) {
          print('DEBUG: No patient found for name: $name');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No patient found. Please contact support.'),
                backgroundColor: Colors.red,
              ),
            );
            AuthUtils.clearToken();
            Navigator.pushReplacementNamed(context, 'Signin');
          });
          return;
        }
        _patientId = patientId;
        await AuthUtils.savePatientId(patientId);
        print('DEBUG: Patient ID retrieved: $_patientId');
      } catch (e) {
        print('DEBUG: Failed to fetch patient ID: $e');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load patient ID: $e'),
              backgroundColor: Colors.red,
            ),
          );
          AuthUtils.clearToken();
          Navigator.pushReplacementNamed(context, 'Signin');
        });
        return;
      }
    }
    try {
      _patientDetails = await PatientByIdService().getPatientById(_patientId!);
      print('DEBUG: Patient details loaded: ${_patientDetails?.id}');
    } catch (e) {
      print('DEBUG: Failed to load patient details: $e');
    }

    print('DEBUG: Patient name retrieved: ${widget.patientName}');
  }

  Future<void> _checkForNotifications() async {
    try {
      final tips = await VitalService().fetchHealthTips();
      setState(() {
        hasNotification = tips.isNotEmpty && tips[0] != 'No health tips available yet.' && tips[0] != 'Error fetching health tips.';
      });
    } catch (e) {
      print('Error checking notifications: $e');
    }
  }

  void _showNotificationsDialog(BuildContext context) async {
    try {
      final tips = await VitalService().fetchHealthTips();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Health Recommendations',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: secondary,
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: tips.isEmpty
                  ? Text(
                'No recommendations available.',
                style: GoogleFonts.nunito(fontSize: 16, color: secondary),
              )
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: tips.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '• ${tips[index]}',
                      style: GoogleFonts.nunito(fontSize: 16, color: secondary),
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Close',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load recommendations: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final icons = [
      Icons.menu_rounded,
      Icons.notifications_none_rounded,
      Icons.qr_code_scanner_rounded,
    ];
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
                colors: [gradient1, gradient2],
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
                                "${_patientDetails?.name ?? widget.patientName}...",
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
                            backgroundImage:
                            const AssetImage("assets/patientAvatar.png"),
                          ),
                          SizedBox(width: width * 0.1),
                          Row(
                            children: List.generate(
                              icons.length,
                                  (index) => GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    showMenuDialog(context);
                                  } else if (index == 1){
                                    _showNotificationsDialog(context); // Show dialog with tips
                                  }
                                  else{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => QRScannerPage()),
                                    );
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
                      await _checkForNotifications(); // Refresh notifications
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
                          FutureBuilder<List<GetReportModel>>(
                            future: _patientId != null
                                ? GetReportService().getReports(_patientId!)
                                : Future.value([]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CustomExpansionTile(
                                  title: "My Diagnoses",
                                  content: Text("Loading..."),
                                );
                              } else if (snapshot.hasError) {
                                final error = snapshot.error.toString();
                                if (error.contains('401')) {
                                  return CustomExpansionTile(
                                    title: "My Diagnoses",
                                    content: Text("Session expired. Please log in again."),
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
                                  content: Text(error.contains('404') ? "No reports found." : "Error: $error"),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.refresh),
                                    onPressed: () => setState(() {}),
                                  ),
                                );
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const CustomExpansionTile(
                                  title: "My Diagnoses",
                                  content: Text("No reports found."),
                                );
                              } else {
                                final reports = snapshot.data!;
                                return CustomExpansionTile(
                                  title: "My Diagnoses",
                                  content: SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: reports.length,
                                      itemBuilder: (context, index) {
                                        final report = reports[index];
                                        return ListTile(
                                          title: Text(report.reportDetails ?? 'No details'),
                                          subtitle: Text('Date: ${report.uploadDate.split('T').first}'),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: height * 0.03),
                          const CustomExpansionTile(
                            title: "My Medicine",
                            content: Text("No this time."),
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