import 'package:flutter/material.dart';

class AnimatedStatusIndicator extends StatefulWidget {
  final StatusItemData item;

  const AnimatedStatusIndicator({Key? key, required this.item}) : super(key: key);

  @override
  _AnimatedStatusIndicatorState createState() => _AnimatedStatusIndicatorState();
}

class _AnimatedStatusIndicatorState extends State<AnimatedStatusIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    Duration duration = _getAnimationDuration(widget.item.label);

    _controller = AnimationController(
      vsync: this,
      duration: duration,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 5.0, end: 15.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  Duration _getAnimationDuration(String label) {
    final lowerLabel = label.toLowerCase();
    if (lowerLabel == 'very bad' ||
        lowerLabel == 'bad' ||
        lowerLabel == 'good' ||
        lowerLabel == 'very good') {
      return const Duration(milliseconds: 700);
    }
    return const Duration(milliseconds: 1500);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = 100.0; // Match PatientHome's 100-pixel size
    final innerCircleSize = circleSize * 0.7;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: widget.item.gradient,
              boxShadow: [
                BoxShadow(
                  color: widget.item.getGlowColor().withOpacity(0.5),
                  blurRadius: _glowAnimation.value,
                  spreadRadius: _glowAnimation.value / 2,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: innerCircleSize,
                height: innerCircleSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    widget.item.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 12.0 : 16.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5DC1C3),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatusItemData {
  final String label;
  late final Gradient gradient;

  StatusItemData({required this.label}) {
    final lowerLabel = label.toLowerCase();
    if (lowerLabel == 'good' || lowerLabel == 'very good') {
      gradient = const LinearGradient(
          colors: [Color(0xFF0EF816), Color(0xFFFBC204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
    } else if (lowerLabel == 'bad') {
      gradient = const LinearGradient(
          colors: [Color(0xFFFF0000), Color(0xFFFBC204)],
          begin: Alignment.topRight,
          end: Alignment.bottomRight);
    } else if (lowerLabel == 'very bad') {
      const Color(0xFFFF0000);
      // gradient = const LinearGradient(
      //     colors: [Color(0xFFFF0000), Color(0xFFFBC204)],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight);
    } else {
      gradient = const LinearGradient(colors: [Colors.grey, Colors.grey]);
    }
  }

  Color getGlowColor() {
    final lowerLabel = label.toLowerCase();
    if (lowerLabel == 'good' || lowerLabel == 'very good') {
      return const Color(0xFF0EF816);
    } else if (lowerLabel == 'bad' || lowerLabel == 'very bad') {
      return const Color(0xFFFF0000);
    } else {
      return Colors.grey;
    }
  }
}

double calculateFontSize(double screenWidth) {
  if (screenWidth >= 1200) {
    return 18;
  } else if (screenWidth >= 800) {
    return 16;
  } else if (screenWidth >= 400) {
    return 14;
  } else {
    return 10;
  }
}