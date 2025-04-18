import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';

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
                AppColors.white,
                const TextStyle(fontSize: 18, color: AppColors.lightCrimson, fontWeight: FontWeight.bold), // title
                const TextStyle(fontSize: 16, color: AppColors.black), // subtitle
                const TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.w300), // trailing
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(AppStrings.darkTheme),
            onTap: () {
              viewModel.setTheme(
                AppColors.black,
                const TextStyle(fontSize: 18, color: AppColors.white, fontWeight: FontWeight.bold),
                const TextStyle(fontSize: 16, color: AppColors.lightCrimson),
                const TextStyle(fontSize: 16, color: AppColors.white70, fontWeight: FontWeight.w300),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(AppStrings.colorfulTheme),
            onTap: () {
              viewModel.setTheme(
                AppColors.cloudBlue,
                const TextStyle(fontSize: 18, color: AppColors.rainyBlue, fontWeight: FontWeight.bold),
                const TextStyle(fontSize: 16, color: AppColors.pinkyPink),
                const TextStyle(fontSize: 16, color: AppColors.gray700, fontWeight: FontWeight.w300),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}