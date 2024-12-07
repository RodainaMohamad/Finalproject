import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grad_project/core/constants/colours/colours.dart';


class Wavyappbar extends StatelessWidget {
  const Wavyappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(flip: true),
      child: Container(
        height: 120,
        color: secondary,
      ),
    );
  }
}