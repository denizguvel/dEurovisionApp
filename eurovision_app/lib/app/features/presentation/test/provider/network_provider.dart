import 'package:eurovision_app/core/network_control/network_control.dart';
import 'package:flutter/material.dart';

class NetworkProvider extends ChangeNotifier {
  final INetworkControl networkControl;

  NetworkResult _status = NetworkResult.on;
  NetworkResult get status => _status;

  NetworkProvider({required this.networkControl}) {
    _init();
  }

  void _init() async {
    _status = await networkControl.checkNetworkFirstTime();
    notifyListeners();

    networkControl.handleNetworkChange((result) {
      _status = result;
      notifyListeners();
    });
  }

  Future<void> checkConnectionManually() async {
    final result = await networkControl.checkNetworkFirstTime();
    _status = result;
    notifyListeners();
  }

  @override
  void dispose() {
    networkControl.dispose();
    super.dispose();
  }
}