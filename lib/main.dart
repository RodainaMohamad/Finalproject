import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/cubits/HeartRate_events.dart';
import 'package:grad_project/cubits/MQTT__Temp_events.dart';
import 'package:grad_project/cubits/OxygenRate_events.dart';
import 'package:grad_project/pages/DoctorPatient.dart';
import 'package:grad_project/pages/Doctorhome.dart';
import 'package:grad_project/pages/PatientHome.dart';
import 'package:grad_project/pages/SignIn.dart';
import 'package:grad_project/pages/SplashScreen.dart';
import 'package:grad_project/pages/create_account_doctor.dart';
import 'package:grad_project/pages/create_account_patient.dart';

void main() {
  runApp(const MyApp());
}
void testStorage() async {
  final storage = FlutterSecureStorage();
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
        BlocProvider(create: (context) => HeartRateCubit()),
        BlocProvider(create: (context) => TemperatureCubit()),
        BlocProvider(create: (context) => OxygenRateCubit()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "PatientHome",
      routes: {
        'Splashscreen': (context) => const Splashscreen(),
        'CreateAccountScreenPatient': (context) => CreateAccountScreenPatient(),
        'Signin': (context) => const Signin(),
        'DoctorPatient': (context) =>const DoctorPatient(),
        'PatientHome': (context) => const PatientHome(),
        'CreateAccountScreenDoctor':(context)=> CreateAccountScreenDoctor(),
        'DoctortHome':(context)=>const Doctorhome(),
      },
    ));
  }
}