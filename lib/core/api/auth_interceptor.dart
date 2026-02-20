// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:feedback_to_vfd/core/helpers/handlers/global_navigation_service.dart';
// import 'package:feedback_to_vfd/core/services/secure_storage_service.dart';
// import 'package:feedback_to_vfd/core/utils/custom_log_file.dart';
// import 'package:feedback_to_vfd/injection_container.dart';

// class AuthInterceptor extends Interceptor {
//   AuthInterceptor(this.dio);

//   final Dio dio;
//   SecureStorageService get secureStorageService =>
//       SecureStorageService.instance;

//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final path = options.path;
//     final isAuthPath =
//         path.contains('signin') ||
//         path.contains('signup') ||
//         path.contains('refresh');

//     kLogs('INTERCEPTOR [onRequest] Path: $path, isAuthPath: $isAuthPath');

//     if (isAuthPath) {
//       kLogs('INTERCEPTOR [onRequest] Auth path detected, removing header');
//       options.headers.remove('Authorization');
//       return handler.next(options);
//     }

//     final accessToken = await secureStorageService.getAccessJwtToken();
//     if (accessToken != null) {
//       kLogs('INTERCEPTOR [onRequest] Access token found, adding to header');
//       options.headers['Authorization'] = 'Bearer $accessToken';
//     } else {
//       kLogs('INTERCEPTOR [onRequest] NO ACCESS TOKEN FOUND IN STORAGE');
//     }

//     handler.next(options);
//   }

//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     final path = err.requestOptions.path;
//     final isRefreshRequest = path.contains('refresh');
//     final isRetry = err.requestOptions.extra['retry'] == true;

//     // If it's a 401/403 and NOT a refresh request and NOT already a retry
//     if ((err.response?.statusCode == 401 || err.response?.statusCode == 403) &&
//         !isRefreshRequest &&
//         !isRetry) {
//       kLogs('Token invalid, attempting to refresh...');
//       final refreshToken = await secureStorageService.getRefreshJwtToken();

//       if (refreshToken != null) {
//         try {
//           final refreshJwtUsecase = sl<RefreshJwtUsecase>();
//           final result = await refreshJwtUsecase.call(refreshToken);

//           await result.fold(
//             (failure) async {
//               kLogs('Refresh failed, logging out...');
//               await _handleSignOut();
//               handler.next(err);
//             },
//             (jwtEntity) async {
//               final newAccessToken = jwtEntity.access;
//               kLogs('Refreshed token successfully');

//               await secureStorageService.saveJwtTokens(jwtEntity);

//               // Update global headers for FUTURE requests
//               dio.options.headers['Authorization'] = 'Bearer $newAccessToken';

//               // Retry the CURRENT request
//               final opts = err.requestOptions;
//               opts.headers['Authorization'] = 'Bearer $newAccessToken';
//               opts.extra['retry'] = true; // Mark as retry to prevent loops

//               try {
//                 final response = await dio.fetch<dynamic>(opts);
//                 handler.resolve(response);
//               } on DioException catch (e) {
//                 handler.next(e);
//               }
//             },
//           );
//           return;
//         } catch (e) {
//           kLogs('Unexpected error during refresh: $e');
//           await _handleSignOut();
//           return handler.next(err);
//         }
//       } else {
//         kLogs('No refresh token found, logging out...');
//         await _handleSignOut();
//       }
//     }

//     if (isRefreshRequest && err.response?.statusCode == 401) {
//       kLogs('Refresh token expired, logging out...');
//       await _handleSignOut();
//     }

//     handler.next(err);
//   }

//   Future<void> _handleSignOut() async {
//     await secureStorageService.deleteAll();
//     dio.options.headers.remove('Authorization');
//     GlobalNavigationService.instance.navigateToLogin();
//   }
// }
