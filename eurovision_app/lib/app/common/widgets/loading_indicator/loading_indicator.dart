import 'package:eurovision_app/app/common/constants/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppAnimations.euheart_ani,
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}