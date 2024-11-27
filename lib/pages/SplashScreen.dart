import 'package:flutter/material.dart';
import 'package:gradproject/core/constants/colours/colours.dart';
import 'package:gradproject/core/widgets/wavyAppBar.dart';
import 'package:gradproject/pages/GetStartedScreen.dart';

import '../core/constants/strings/strings.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
     body: Column(
       children: [
         const Stack(
             children:[
               Wavyappbar(),
             ]),
         const SizedBox(height:75),
         Center(
          child: logo,
         ),
         const SizedBox(height:5),
         GestureDetector(
           child: arrow,
           onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Getstartedscreen()));}
           ,),
         splashImage,
       ],
     ),
    );
  }
}