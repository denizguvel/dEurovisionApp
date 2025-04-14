import 'package:eurovision_app/app/common/constants/app_animations.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
                context.read<NetworkProvider>().checkConnectionManually();
              },
              child: const Text(AppStrings.tryAgain),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.crimson),
            ),
          ],
        ),
        // child: Text(
        //   'No Internet Connection',
        //   style: TextStyle(fontSize: 20, color: Colors.red),
        // ),
      ),
    );
  }
}