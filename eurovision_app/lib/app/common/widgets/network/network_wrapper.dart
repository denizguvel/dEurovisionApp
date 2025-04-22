import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/feature/view/no_internet_view.dart';
import 'package:eurovision_app/core/network_control/network_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A widget that wraps its child with a network status check.
/// If the network status is off, it shows a [NoInternetScreen].
class NetworkWrapper extends StatelessWidget {
  final Widget child;

  const NetworkWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final networkStatus = context.watch<FeatureProvider>().status;

    if (networkStatus == NetworkResult.off) {
      return const NoInternetScreen();
    }

    return child;
  }
}