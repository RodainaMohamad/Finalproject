import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/cubits/HealthStatusEvents.dart';
import 'package:grad_project/cubits/HeartRate_events.dart';
import 'package:grad_project/cubits/MQTT__Temp_events.dart';
import 'package:grad_project/cubits/OxygenRate_events.dart';
import 'package:grad_project/cubits/auth_events.dart';
import 'package:grad_project/pages/DoctorPatient.dart';
import 'package:grad_project/pages/Doctorhome.dart';
import 'package:grad_project/pages/ForgotPasswordPage.dart';
import 'package:grad_project/pages/PatientHome.dart';
import 'package:grad_project/pages/QRScanner.dart';
import 'package:grad_project/pages/SignIn.dart';
import 'package:grad_project/pages/SplashScreen.dart';
import 'package:grad_project/pages/create_account_doctor.dart';
import 'package:grad_project/pages/create_account_patient.dart';

void main() {
  runApp(const MyApp());
}

void testStorage() async {
  final storage = const FlutterSecureStorage();
  try {
    await storage.write(key: 'test_key', value: 'test_value');
    final value = await storage.read(key: 'test_key');
    print('Secure storage test: $value');
  } catch (e) {
    print('Secure storage error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HeartRateCubit()),
        BlocProvider(create: (context) => TemperatureCubit()),
        BlocProvider(create: (context) => OxygenRateCubit()),
        BlocProvider(
          create: (context) => HealthStatusCubit(
            heartRateCubit: context.read<HeartRateCubit>(),
            temperatureCubit: context.read<TemperatureCubit>(),
            oxygenRateCubit: context.read<OxygenRateCubit>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "Signin",
        routes: {
          'Splashscreen': (context) => const Splashscreen(),
          'CreateAccountScreenPatient': (context) => const CreateAccountScreenPatient(),
          'Signin': (context) => const Signin(),
          'DoctorPatient': (context) => const DoctorPatient(),
          'PatientHome': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
            return PatientHome(
              patientName: args?['patientName'] ?? 'Unknown Patient',
            );
          },
          'DoctortHome': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return Doctorhome(
              doctorName: args['doctorName'] as String,
            );
          },
          'CreateAccountScreenDoctor': (context) => const CreateAccountScreenDoctor(),
          'QRScannerPage': (context) =>  QRScannerPage(),
          'ForgotPasswordPage': (context) => ForgotPasswordPage(),
        },
      ),
    );
  }
}