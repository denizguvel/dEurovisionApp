import 'package:eurovision_app/app/features/data/datasources/remote/contestant_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/home/provider/constestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/provider/contestant_detail_provider.dart';
//import 'package:eurovision_app/app/features/presentation/test/provider/contestant/contestant_top_ten_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';
import 'package:eurovision_app/app/features/presentation/search_video/provider/video_provider.dart';
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
        // ChangeNotifierProvider(create: (_) => AllContestantsProvider(ContestantTenRemoteDatasourceImpl(),EurovisionRemoteDatasourceImpl())),
        ChangeNotifierProvider(create: (_) => MyTop10Provider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
    
      ],
      child: child,
    );
  }

  static Future<void> reset(BuildContext context) async {
  }
}
