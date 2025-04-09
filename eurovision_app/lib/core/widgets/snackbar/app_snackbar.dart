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
      backgroundColor: backgroundColor ?? Colors.black,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor ?? Colors.white,
        ),
      ),
    );
    if (AppKeys.scaffoldMessengerKey.currentState == null) {
      return;
    }
    AppKeys.scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }
}
