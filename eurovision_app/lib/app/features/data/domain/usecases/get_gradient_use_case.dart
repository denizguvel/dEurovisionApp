import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/app/features/data/domain/entities/gradient_entity.dart';

/// Returns a predefined gradient configuration to be used across the app.
/// Useful for maintaining visual consistency in themed components.
class GetGradientUseCase {
  GradientEntity call() {
    return GradientEntity(
      colors: [AppColors.pinkyPink, AppColors.airBlue, AppColors.black, AppColors.raspberryRose, AppColors.jet, AppColors.davysGray],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
