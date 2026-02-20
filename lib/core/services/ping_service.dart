// import 'package:feedback_to_vfd/core/api/network_requests.dart';

// class PingService extends NetworkService {
//   factory PingService() => _instance;
//   PingService._();
//   static final PingService _instance = PingService._();

//   Future<bool> pingServer() async {
//     try {
//       const path = 'ping';
//       final response = await getRequest(path);
//       // kLogs('Ping server response is $response');
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }
// }
