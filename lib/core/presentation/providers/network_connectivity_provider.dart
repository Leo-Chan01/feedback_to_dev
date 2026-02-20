import 'package:flutter/material.dart';

class NetworkConnectivityProvider extends ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  // ignore: avoid_positional_boolean_parameters
  void updateConnectivityStatus(bool value) {
    _isConnected = value;
    notifyListeners();
  }
}
