import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

typedef NetworkCallback = void Function(NetworkResult result);

abstract class INetworkControl {
  Future<NetworkResult> checkNetworkFirstTime();
  void handleNetworkChange(NetworkCallback onChanged);
  void dispose();
}

class NetworkControl extends INetworkControl {
  late final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  NetworkControl() : _connectivity = Connectivity();

  @override
  Future<NetworkResult> checkNetworkFirstTime() async {
    final List<ConnectivityResult> connectivityResult =
        await (_connectivity.checkConnectivity());
    return NetworkResult.checkConnetivityResult(connectivityResult);
  }

  @override
  void handleNetworkChange(NetworkCallback onChanged) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      onChanged.call(NetworkResult.checkConnetivityResult(event));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}

enum NetworkResult {
  on,
  off;

  static NetworkResult checkConnetivityResult(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile)) {
      return NetworkResult.on;
    } else if (result.contains(ConnectivityResult.wifi)) {
      return NetworkResult.on;
    } else if (result.contains(ConnectivityResult.ethernet)) {
      return NetworkResult.on;
    } else if (result.contains(ConnectivityResult.vpn)) {
      return NetworkResult.off;
    } else if (result.contains(ConnectivityResult.bluetooth)) {
      return NetworkResult.on;
    } else if (result.contains(ConnectivityResult.other)) {
      return NetworkResult.on;
    } else if (result.contains(ConnectivityResult.none)) {
      return NetworkResult.off;
    } else {
      return NetworkResult.off;
    }
  }
}
