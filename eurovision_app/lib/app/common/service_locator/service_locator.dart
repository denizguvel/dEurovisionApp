import 'package:eurovision_app/app/features/data/datasources/remote/contestant_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/home/provider/constestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/provider/contestant_detail_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';
import 'package:eurovision_app/app/features/presentation/search_video/provider/video_provider.dart';
import 'package:eurovision_app/app/features/presentation/search_video/view/video_view.dart';
import 'package:eurovision_app/core/network_control/network_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A singleton class that sets up the service locator for the app.
class ServiceLocator {
  static Widget setup({required Widget child}) {
    return MultiProvider(
      providers: [
        // Provider/State Management Provider
        Provider<EurovisionRemoteDatasource>(
          create: (_) => EurovisionRemoteDatasourceImpl(),
        ),
        ChangeNotifierProvider(
          create: (_) => FeatureProvider(
            networkControl: NetworkControl(),
          ),
        ),
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
        ChangeNotifierProvider(create: (_) => MyTop10Provider()),
        ChangeNotifierProvider(
          create: (_) => VideoProvider()..init(),
          child: const VideoView(),
        )
      ],
      child: child,
    );
  }
  static Future<void> reset(BuildContext context) async {
  }
}