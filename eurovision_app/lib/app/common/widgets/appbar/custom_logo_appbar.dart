import 'package:eurovision_app/app/common/constants/app_icons.dart';
import 'package:flutter/material.dart';

class CustomLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Gradient backgroundGradient;

  const CustomLogoAppBar({super.key, required this.backgroundGradient});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        width: double.infinity,
        //padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        //alignment: Alignment.center,
        child: Image.asset(AppIcons.euBanner,
          width: double.infinity,
          height: kToolbarHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}