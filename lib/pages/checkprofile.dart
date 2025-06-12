import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../API_integration/models/patientmodel.dart';
import '../../cubits/HeartRate_events.dart';
import '../../cubits/HeartRate_states.dart';
import '../../cubits/MQTT__Temp_events.dart';
import '../../cubits/MQTT__Temp_states.dart';
import '../../cubits/OxygenRate_events.dart';
import '../../cubits/OxygenRate_states.dart';
import 'package:grad_project/core/constants/colours/colours.dart';

import '../core/widgets/AnimatedStatusIndicator.dart';
import '../core/widgets/statusCards.dart';
import '../cubits/HealthStatusEvents.dart';
import '../cubits/HealthStatusState.dart';

class CheckProfile extends StatelessWidget {
  final Patient patient;

  const CheckProfile({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF22E0E4),
              Color(0xFF2C5C5D),
            ],
          ),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                // الخلفية الشفافة
                Container(
                  width: 300,
                  height: 600,
                  color: const Color(0xB2298183),
                ),

                // نوتش مع صورة
                Positioned(
                  top: 0,
                  left: 90,
                  right: 90,
                  child: Container(
                    width: 120,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/notch_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // الاسم والمعلومات
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        patient.name ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.badge, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  patient.ssn ?? 'No SSN',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<HealthStatusCubit, HealthStatusState>(
                        builder: (context, state) {
                          if (state.statusItemData.label == 'Unknown') {
                            return Text(
                              'Waiting for data...',
                              style: TextStyle(
                                color: secondary,
                                fontSize: 15,
                              ),
                            );
                          }
                          return AnimatedStatusIndicator(
                            item: state.statusItemData,
                          );
                        },
                      ),
                      const SizedBox(height: 30),

                      // إضافة الكروت الثلاثة هنا
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // كارت معدل ضربات القلب
                              BlocBuilder<HeartRateCubit, HeartRateState>(
                                builder: (context, state) {
                                  return StatusCard(
                                    image: Image.asset(
                                      "assets/heartRate.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    title: "Heart Rate",
                                    value: _getHeartRateValue(state),
                                    unit: "bpm",
                                  );
                                },
                              ),
                              SizedBox(width: width * 0.02),

                              // كارت درجة الحرارة
                              BlocBuilder<TemperatureCubit, TemperatureState>(
                                builder: (context, state) {
                                  return StatusCard(
                                    image: Image.asset(
                                      "assets/temp.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    title: "Temperature",
                                    value: _getDisplayValue(state),
                                    unit: "°C",
                                  );
                                },
                              ),
                              SizedBox(width: width * 0.02),

                              // كارت مستوى الأكسجين
                              BlocBuilder<OxygenRateCubit, OxygenRateState>(
                                builder: (context, state) {
                                  return StatusCard(
                                    image: Image.asset(
                                      "assets/pressure.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    title: "Oxygen",
                                    value: _getOxygenValue(state),
                                    unit: "%",
                                  );
                                },
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

  // الدوال المساعدة للحصول على القيم
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
