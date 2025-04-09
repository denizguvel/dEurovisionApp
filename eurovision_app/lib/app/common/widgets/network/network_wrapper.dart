import 'package:eurovision_app/app/features/presentation/test/provider/network_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/view/no_internet_view.dart';
import 'package:eurovision_app/core/network_control/network_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkWrapper extends StatelessWidget {
  final Widget child;

  const NetworkWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final networkStatus = context.watch<NetworkProvider>().status;

    if (networkStatus == NetworkResult.off) {
      return const NoInternetScreen();
    }

    return child;
  }
}