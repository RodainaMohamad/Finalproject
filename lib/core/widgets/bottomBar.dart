import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grad_project/core/constants/colours/colours.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(reverse: true),
      child: Container(
        height: 121,
        color: secondary,
        child: Row(
          children: [
            GestureDetector(
              onTap: (){},
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary,
                ),
                child: Center(
                  heightFactor:25,
                  widthFactor: 25,
                  child:IconButton(
                    icon: Image.asset(
                      "assets/backArrow.png",
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () {Navigator.pop(context);},
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}