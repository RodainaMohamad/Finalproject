import 'package:flutter/material.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/BottomIconButton.dart';

class BottomNavWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: Container(
        height: 60,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/Rectangle 900.png",
                fit: BoxFit.cover,
                height: 60,
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomIconButton(
                    icon: Icons.local_hospital,
                    onPressed: () {
                      print("EMERGENCY button pressed");
                    },
                  ),
                  BottomIconButton(
                    icon: Icons.home,
                    onPressed: () {
                      print("HOME button pressed");
                    },
                  ),
                  BottomIconButton(
                    icon: Icons.help_outline,
                    onPressed: () {
                      print("? button pressed");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}