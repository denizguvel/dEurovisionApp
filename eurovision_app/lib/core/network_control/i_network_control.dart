import 'package:eurovision_app/core/network_control/network_control.dart';

/// Abstract interface for managing network status.
/// Defines initial check, change listener, and dispose methods.
typedef NetworkCallback = void Function(NetworkResult result);

abstract class INetworkControl {
  Future<NetworkResult> checkNetworkFirstTime();
  void handleNetworkChange(NetworkCallback onChanged);
  void dispose();
}
