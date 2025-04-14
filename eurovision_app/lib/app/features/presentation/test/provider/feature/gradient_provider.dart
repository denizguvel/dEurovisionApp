import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/app/features/data/domain/usecases/get_gradient_use_case.dart';
import 'package:eurovision_app/app/features/data/domain/entities/gradient_entity.dart';

class GradientProvider extends ChangeNotifier {
  final GetGradientUseCase _getGradientUseCase = GetGradientUseCase();

  GradientEntity _gradient = GradientEntity(
    //colors: [AppColors.crimson, AppColors.airBlue, AppColors.black, AppColors.raspberryRose, AppColors.jet, AppColors.davysGray],
    colors: [AppColors.lightCrimson, AppColors.crimson, AppColors.crimson1, AppColors.crimson2, AppColors.crimson3, AppColors.black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  GradientEntity get gradient => _gradient;

  void updateGradient() {
    _gradient = _getGradientUseCase();
    notifyListeners();
  }
}
