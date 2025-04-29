// import 'package:flutter/material.dart';
// import 'package:grad_project/pages/DoctorPatient.dart';
// import 'package:grad_project/pages/PatientHome.dart';
// import 'package:grad_project/pages/SignIn.dart';
// import 'package:grad_project/pages/SplashScreen.dart';
// import 'package:grad_project/pages/create_account_doctor.dart';
// import 'package:grad_project/pages/create_account_patient.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';
//
// void main() {
//   // MqttServerClient client =MqttServerClient.withPort("hostName", "clientIdentifier", 8883);
//   // MqttClientPayloadBuilder p=MqttClientPayloadBuilder();
//   // client.connect().then((value)=>
//   // {
//   //   if(value!.state == client.connectionStatus!.state){
//   //     client.subscribe("sensor/temperature", MqttQos.atMostOnce),
//   //     p.addString("hello from FLUTTER!!!!!!!!"),
//   //     client.publishMessage("sensor/temperature", MqttQos.atMostOnce, p.payload!),
//   //     client.updates!.listen((event){}),
//   //   }
//   // });
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: "PatientHome",
//       routes: {
//         'Splashscreen': (context) => const Splashscreen(),
//         'CreateAccountScreenPatient': (context) => CreateAccountScreenPatient(),
//         'Signin': (context) => const Signin(),
//         'DoctorPatient': (context) =>const DoctorPatient(),
//         'PatientHome': (context) => const Patienthome(),
//         'CreateAccountScreenDoctor':(context)=> CreateAccountScreenDoctor(),
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubits/HeartRate_events.dart';
import 'package:grad_project/cubits/MQTT__Temp_events.dart';
import 'package:grad_project/cubits/OxygenRate_events.dart';
import 'package:grad_project/pages/DoctorPatient.dart';
import 'package:grad_project/pages/PatientHome.dart';
import 'package:grad_project/pages/SignIn.dart';
import 'package:grad_project/pages/SplashScreen.dart';
import 'package:grad_project/pages/create_account_doctor.dart';
import 'package:grad_project/pages/create_account_patient.dart';

void main() {
  runApp(const MyApp());
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
          'DoctorPatient': (context) => const DoctorPatient(),
          'PatientHome': (context) =>  const PatientHome(),
          'CreateAccountScreenDoctor': (context) => CreateAccountScreenDoctor(),
        },
      ),
    );
  }
}