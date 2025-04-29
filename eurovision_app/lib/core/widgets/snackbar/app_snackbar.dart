import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../keys/keys.dart';

class AppSnackBar {
  final String message;

  AppSnackBar({
    required this.message,
  });

  static show(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
  }) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor ?? AppColors.black,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor ?? AppColors.white,
        ),
      ),
    );
    if (AppKeys.scaffoldMessengerKey.currentState == null) {
      return;
    }
    AppKeys.scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }
}
