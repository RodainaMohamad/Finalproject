import 'package:flutter/material.dart';
import 'package:grad_project/core/constants/colours/colours.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String content;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFA4E2E3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          collapsedIconColor: secondary,
          iconColor: secondary,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: secondary,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}