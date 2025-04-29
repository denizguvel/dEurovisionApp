import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';

/// Bottom sheet widget for theme selection.
/// Allows switching between light and dark themes.
class ThemePickerBottomSheet extends StatelessWidget {
  const ThemePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MyTop10Provider>();

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text(AppStrings.lightTheme),
            onTap: () {
              viewModel.setTheme(
                color: AppColors.white,
                title: const TextStyle(fontSize: 18, color: AppColors.pinkyPink, fontWeight: FontWeight.bold), // title
                subtitle: const TextStyle(fontSize: 16, color: AppColors.black), // subtitle
                trailing: const TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.w300), // trailing
                iconColor: AppColors.gray,
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(AppStrings.darkTheme),
            onTap: () {
              viewModel.setTheme(
                color: AppColors.black,
                title: const TextStyle(fontSize: 18, color: AppColors.pinkyPink, fontWeight: FontWeight.bold),
                subtitle: const TextStyle(fontSize: 16, color: AppColors.spanishGray),
                trailing: const TextStyle(fontSize: 16, color: AppColors.white70, fontWeight: FontWeight.w300),
                iconColor: AppColors.white70,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}