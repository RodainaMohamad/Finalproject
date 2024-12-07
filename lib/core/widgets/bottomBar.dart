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
        height: 120,
        color: secondary,
      ),
    );
  }
}
