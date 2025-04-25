import 'package:eurovision_app/app/common/constants/app_animations.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/feature/view/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Animated splash screen shown at app startup.
/// Navigates automatically to the main page after a delay.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const MainScaffold()),
  );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AppAnimations.splash_ani,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20,),
              Text(AppStrings.appName, style: TextStyle(color: AppColors.crimson5, fontWeight: FontWeight.bold, fontSize: 40),)
            ],
          ),
        ),
      ),
    );
  }
}
