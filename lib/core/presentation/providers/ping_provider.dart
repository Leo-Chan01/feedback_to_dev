// import 'package:feedback_to_vfd/core/services/ping_service.dart';
// import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
// import 'package:flutter/foundation.dart';

// class PingProvider extends ChangeNotifier {
//   PingProvider({required this.service});

//   PingService service;

//   bool _isServerReachable = false;
//   bool get isServerReachable => _isServerReachable;

//   bool _isCheckingServerStatus = false;
//   bool get isCheckingServerStatus => _isCheckingServerStatus;

//   Future<bool> setServerReachable() async {
//     // kLogs('Checking if server is reachable...');
//     _isCheckingServerStatus = true;
//     notifyListeners();
//     _isServerReachable = await service.pingServer();
//     notifyListeners();
//     // kLogs('Server reachable: $_isServerReachable');
//     _isCheckingServerStatus = false;
//     notifyListeners();
//     return _isServerReachable;
//   }

//   Future<void> callRelevantFunctions() async {
//     // await setServerReachable();
//   }
// }
