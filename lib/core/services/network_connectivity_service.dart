import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feedback_to_vfd/core/presentation/providers/network_connectivity_provider.dart';

class NetworkConnectivityService {
  factory NetworkConnectivityService() {
    return _singleton;
  }

  NetworkConnectivityService._internal();
  static final NetworkConnectivityService _singleton =
      NetworkConnectivityService._internal();

  late StreamSubscription<List<ConnectivityResult>> subscription;

  void subscribeToNetworkListner(NetworkConnectivityProvider networkProvider) {
    // kLogs('Listener function called');
    subscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) {
      // kLogs('Inside the listener function for network');
      for (final element in result) {
        if (element == ConnectivityResult.none) {
          // networkProvider.updateConnectivityStatus(false);
          networkProvider.updateConnectivityStatus(false);
          // kLogs('No internet');
        } else {
          // kLogs('Internet connection is available');
          networkProvider.updateConnectivityStatus(true);
        }
      }
    });
  }

  void cancelSubscription() {
    subscription.cancel();
  }
}
