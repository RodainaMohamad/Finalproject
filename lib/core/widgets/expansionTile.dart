import 'package:flutter/material.dart';
import 'package:grad_project/core/constants/colours/colours.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final dynamic content; // Changed to dynamic to accept both String and Widget
  final Widget? trailing;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.content,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFA4E2E3),
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
          trailing: trailing,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: content is String
                  ? Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: secondary,
                ),
              )
                  : content, // If it's a Widget, use it directly
            ),
          ],
        ),
      ),
    );
  }
}