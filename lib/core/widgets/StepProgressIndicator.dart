import 'package:flutter/material.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Stepprogressindicator extends StatelessWidget {
  const Stepprogressindicator({super.key});

  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: 6,
      currentStep: 1,
      size: 10,
      selectedColor: secondary,
      unselectedColor: primary,
    );
  }
}
