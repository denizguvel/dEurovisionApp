import 'package:eurovision_app/app/common/constants/app_theme_data.dart';
import 'package:eurovision_app/app/common/functions/app_functions.dart';
import 'package:eurovision_app/app/common/service_locator/service_locator.dart';
import 'package:eurovision_app/app/common/widgets/network/network_wrapper.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/splash/view/splash_view.dart';
import 'package:eurovision_app/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:eurovision_app/core/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await AppFunctions.instance.init(); 
  runApp(ServiceLocator.setup(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: Navigation.navigationKey,
        scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        themeMode: context.watch<ThemeProvider>().themeMode,
        home: const SplashView(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
        return NetworkWrapper(child: child ?? SizedBox.shrink());
      },
    );
  }
}