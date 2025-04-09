import 'package:eurovision_app/core/network_control/network_control.dart';

typedef NetworkCallback = void Function(NetworkResult result);

abstract class INetworkControl {
  Future<NetworkResult> checkNetworkFirstTime();
  void handleNetworkChange(NetworkCallback onChanged);
  void dispose();
}
