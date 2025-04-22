import 'package:eurovision_app/app/common/constants/app_animations.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

/// Screen displayed when there is no internet connection.
/// Shows an animation and a retry button for manual check.
class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.noConnection)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAnimations.no_wifi, width: 300, height: 300,),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<FeatureProvider>().checkConnectionManually();
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.crimson),
              child: const Text(AppStrings.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}