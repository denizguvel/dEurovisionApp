import 'package:eurovision_app/app/features/data/datasources/local/test_local_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/test_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/repositories/test_repository.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/appbar_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/cat_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/constestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contest_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/gradient_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/network_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/test_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/theme_provider.dart';
import 'package:eurovision_app/core/network_control/network_control.dart';
import 'package:eurovision_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// **Service provider class managing all dependencies**
class ServiceLocator {
  /// **Main method to call to set up dependencies**
  static Widget setup({required Widget child}) {
    return MultiProvider(
      providers: [
        // // DataSource Provider
        // Provider<TestRemoteDatasource>(
        //   create: (_) => TestRemoteDatasourceImpl(),
        // ),
        // Provider<TestLocalDatasource>(
        //   create: (_) => TestLocalDatasourceImpl(),
        // ),
        // // Repository Provider
        // Provider<TestRepository>(
        //   create: (context) => TestRepositoryImpl(
        //     remoteDatasource: context.read<TestRemoteDatasource>(),
        //     localDatasource: context.read<TestLocalDatasource>(),
        //   ),
        // ),
        // Provider/State Management Provider
        ChangeNotifierProvider(create: (_) => GradientProvider()),
        ChangeNotifierProvider<TestProvider>(
          create: (context) => TestProvider(testRepository: context.read<TestRepository>()),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
         ChangeNotifierProvider(create: (context) => CatProvider()),
         ChangeNotifierProvider(
          create: (_) => NetworkProvider(networkControl: NetworkControl()),
        ),
        ChangeNotifierProvider(create: (context) => ContestProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => AppBarProvider()),
         ChangeNotifierProvider(
          create: (_) => ContestantProvider(
            ContestantTenRemoteDatasourceImpl(),
          ),
        ),
      ],
      child: child,
    );
  }

  /// **Resets dependencies for Test and Debug**
  static Future<void> reset(BuildContext context) async {
    // Any necessary reset logic can be added here
    // For example, clearing shared preferences, resetting services, etc.
    // You can also refresh your dependencies as needed.
  }
}
