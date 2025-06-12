import 'package:flutter/material.dart';

class BackButtonCircle extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  final Color backgroundColor;

  const BackButtonCircle({
    super.key,
    this.onPressed,
    this.size = 50.0,
    this.backgroundColor = const Color(0xFF298183),
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft, // محاذاة لأسفل يسار الشاشة
      child: Container(
        margin: const EdgeInsets.only(
            left: 5, bottom: 20), // زودت المسافة على اليسار من 20 إلى 40
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          iconSize: size,
          onPressed: onPressed ?? () => Navigator.maybePop(context),
        ),
      ),
    );
  }
}
