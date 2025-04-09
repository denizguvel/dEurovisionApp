import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

final class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool hasBorder;
  final Widget? icon;
  final bool shrinkWrap;
  final double height;
  final TextStyle? textStyle;
  final double? width;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.hasBorder = false,
    this.icon,
    this.shrinkWrap = false,
    this.height = 50,
    this.textStyle,
    this.width,
    this.borderRadius,
  });

  factory AppButton.fill({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    Widget? icon,
    bool shrinkWrap = false,
    Color? backgroundColor,
    Color? textColor,
    double height = 50,
    TextStyle? textStyle,
    double? width,
    double? borderRadius,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.hanPurple,
      textColor: textColor ?? AppColors.ghostWhite,
      hasBorder: false,
      icon: icon,
      shrinkWrap: shrinkWrap,
      height: height,
      textStyle: textStyle,
      width: width,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize:
            Size(shrinkWrap ? width ?? 0 : width ?? double.infinity, height),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        overlayColor: textColor,
        side: onPressed == null
            ? null
            : hasBorder
                ? BorderSide(
                    color: textColor,
                    width: 1,
                  )
                : null,
        elevation: 0,
        shadowColor: Colors.transparent,
        disabledBackgroundColor: AppColors.nickel,
      ),
      child: icon == null
          ? Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: onPressed == null ? AppColors.white : textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: textStyle ??
                      TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(width: 4),
                icon!,
              ],
            ),
    );
  }
}
