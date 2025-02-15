import 'package:flutter/material.dart';
import 'package:grad_project/core/constants/colours/colours.dart';

class BottomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const BottomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent, // لا يوجد لون افتراضي
          child: InkWell(
            onTap: onPressed, // تفاعل الضغط
            borderRadius: BorderRadius.circular(35),
            child: Container(
              height:120.3,
              width: 52,
              decoration:  BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: secondary,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}