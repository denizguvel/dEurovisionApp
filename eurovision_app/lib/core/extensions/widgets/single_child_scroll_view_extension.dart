import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

extension SingleChildScrollViewExtensions on Widget {
  Widget scroll(bool isScroll) {
    if (!isScroll) {
      return SizedBox(
        child: this,
      );
    }
    return SingleChildScrollView(
      child: ColoredBox(color: AppColors.transparent, child: this),
    );
  }
}