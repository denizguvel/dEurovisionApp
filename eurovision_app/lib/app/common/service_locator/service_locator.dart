import 'package:eurovision_app/app/features/data/datasources/remote/contestant_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/allcontestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/home/provider/constestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/contest_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/provider/contestant_detail_provider.dart';
//import 'package:eurovision_app/app/features/presentation/test/provider/contestant/contestant_top_ten_provider.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/country_name_provider.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/appbar_provider.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/gradient_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/frame_theme_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/my_top_ten_provider.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/network_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/selected_top_ten_provider.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/theme_provider.dart';
import 'package:eurovision_app/core/network_control/network_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceLocator {
  static Widget setup({required Widget child}) {
    return MultiProvider(
      providers: [
        // Provider/State Management Provider
        ChangeNotifierProvider(create: (_) => GradientProvider()),
        Provider<EurovisionRemoteDatasource>(
          create: (_) => EurovisionRemoteDatasourceImpl(),
        ),
        ChangeNotifierProvider<CountryScoreProvider>(
          create: (context) => CountryScoreProvider(context.read<EurovisionRemoteDatasource>()),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => NetworkProvider(networkControl: NetworkControl()),
        ),
        ChangeNotifierProvider(create: (context) => ContestProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => AppBarProvider()),
        ChangeNotifierProvider(
          create: (_) => ContestantDetailProvider(
            ContestantDetailRemoteDatasourceImpl(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ContestantProvider(
            ContestantTenRemoteDatasourceImpl(),
          ),
        ),
        // ChangeNotifierProvider(create: (_) => ContestantTopTenProvider()),
        ChangeNotifierProvider(create: (_) => FrameThemeProvider()),
        ChangeNotifierProvider(create: (_) => SelectedTop10Provider()),
        ChangeNotifierProvider(create: (_) => AllContestantsProvider(ContestantTenRemoteDatasourceImpl(),EurovisionRemoteDatasourceImpl())),
        ChangeNotifierProvider(create: (_) => MyTopTenProvider()),
      ],
      child: child,
    );
  }

  static Future<void> reset(BuildContext context) async {
  }
}
