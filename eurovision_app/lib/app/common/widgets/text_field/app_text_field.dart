import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isNumeric;
  final VoidCallback? onTap;
  final bool enabled;
  final int? maxLines;
  final Color? backgroundColor;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final String? errorText;
  final bool obscureText;
  final bool hasBorder;
  final EdgeInsetsGeometry? contentPadding;
  final double? radius;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.isNumeric = false,
    this.onTap,
    this.enabled = true,
    this.maxLines,
    this.backgroundColor,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.obscureText = false,
    this.hasBorder = true,
    this.contentPadding,
    this.radius,
  });

  factory AppTextField.search({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    Color? backgroundColor,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    bool hasBorder = true,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      onTap: onTap,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: backgroundColor,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hasBorder: hasBorder,
    );
  }

  factory AppTextField.normal({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    Color? backgroundColor,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    int maxLines = 1,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      onTap: onTap,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: backgroundColor,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      maxLines: maxLines,
      contentPadding: contentPadding,
    );
  }

  factory AppTextField.rightIcon({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required Widget suffixIcon,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    Color? backgroundColor,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      suffixIcon: suffixIcon,
      onTap: onTap,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      backgroundColor: backgroundColor,
    );
  }

  factory AppTextField.numeric({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    bool italic = false,
    Widget? prefixIcon,
    VoidCallback? onTap,
    bool enabled = true,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      isNumeric: true,
      prefixIcon: prefixIcon,
      onTap: onTap,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
    );
  }

  factory AppTextField.leftIcon({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required Widget prefixIcon,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    double? radius,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      onTap: onTap,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxLines: 1,
      errorText: errorText,
      radius: radius,
    );
  }

  factory AppTextField.password({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    bool obscureText = true,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      onTap: onTap,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxLines: 1,
      errorText: errorText,
      obscureText: obscureText,
    );
  }

  factory AppTextField.mutliLine({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    int? maxLines = 2,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      onTap: onTap,
      enabled: enabled,
      maxLines: maxLines,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: const TextStyle(
        color: AppColors.smokyBlack,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
      maxLines: maxLines,
      onTap: onTap,
      enabled: enabled,
      keyboardType: isNumeric ? TextInputType.number : null,
      inputFormatters: isNumeric
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: AppColors.nickel,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 16,
        ),
        fillColor: backgroundColor ?? AppColors.pureWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: hasBorder
              ? const BorderSide(
                  color: AppColors.platinum,
                )
              : BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: hasBorder
              ? const BorderSide(
                  color: AppColors.palePink,
                )
              : BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: hasBorder
              ? const BorderSide(
                  color: AppColors.platinum,
                )
              : BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: hasBorder
              ? const BorderSide(
                  color: AppColors.platinum,
                )
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: hasBorder
              ? const BorderSide(
                  color: AppColors.platinum,
                )
              : BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: hasBorder
              ? const BorderSide(
                  color: AppColors.platinum,
                )
              : BorderSide.none,
        ),
      ),
    );
  }
}