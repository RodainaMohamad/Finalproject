       import 'package:flutter/material.dart';

class PatientStatusPage extends StatelessWidget {
  final List<String> statuses = [
    'Good',
    'Very Good',
    'Bad',
    'Very Good',
    'Good',
    'Very Bad',
  ];

  PatientStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                int crossAxisCount = 3;
                if (constraints.maxWidth >= 900) {
                  crossAxisCount = 5;
                } else if (constraints.maxWidth >= 600) {
                  crossAxisCount = 4;
                }

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34ABAD),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 15,
                        spreadRadius: 5,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                              endIndent: 8,
                            ),
                          ),
                          Text(
                            'Over Look',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                              indent: 8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: statuses.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          final statusData = StatusItemData(label: statuses[index]);
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StatusItem(item: statusData),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 4,
                                alignment: WrapAlignment.center,
                                children: [
                                  _buildSquareBox(
                                      color: const Color(0xFF0EF816),
                                      screenWidth: constraints.maxWidth),
                                  _buildSquareBox(
                                      color: const Color(0xFFE4C206),
                                      screenWidth: constraints.maxWidth),
                                  _buildSquareBox(
                                      color: const Color(0xFFFE4A49),
                                      screenWidth: constraints.maxWidth),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquareBox({required Color color, required double screenWidth}) {
    final size = screenWidth * 0.035;
    return Container(
      width: size,
      height: size * 0.6,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

class StatusItem extends StatefulWidget {
  final StatusItemData item;
  const StatusItem({Key? key, required this.item}) : super(key: key);

  @override
  _StatusItemState createState() => _StatusItemState();
}

class _StatusItemState extends State<StatusItem> with SingleTickerProviderStateMixin {
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
    if (lowerLabel == 'very bad') {
      return const Duration(milliseconds: 700);
    } else if (lowerLabel == 'bad') {
      return const Duration(milliseconds: 1000);
    } else if (lowerLabel == 'good') {
      return const Duration(milliseconds: 1800);
    } else if (lowerLabel == 'very good') {
      return const Duration(milliseconds: 2200);
    } else {
      return const Duration(milliseconds: 1500);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth * 0.12;
    final innerCircleSize = circleSize * 0.7;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF5DC1C3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Current Status',
            style: TextStyle(
              fontSize: calculateFontSize(screenWidth),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
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
                            fontSize: screenWidth < 600 ? 10.0 : 14.0,
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
          ),
        ],
      ),
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
          colors: [Color(0xFFFF0000), Color(0xFF0EF816), Color(0xFFFBC204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
    } else if (lowerLabel == 'very bad') {
      gradient = const LinearGradient(
          colors: [Color(0xFFFF0000), Color(0xFFFBC204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
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