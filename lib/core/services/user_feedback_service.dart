// import 'dart:io';

// import 'package:feedback_to_vfd/core/api/network_requests.dart';
// import 'package:feedback_to_vfd/core/helpers/handlers/exception_handlers.dart';
// import 'package:feedback_to_vfd/core/utils/custom_log_file.dart';
// import 'package:dio/dio.dart';

// class UserFeedbackService extends NetworkService {
//   factory UserFeedbackService() => _instance;
//   UserFeedbackService._internal();
//   static final UserFeedbackService _instance = UserFeedbackService._internal();

//   Future<({int? statusCode, Map<String, dynamic>? data, String? errorMessage})>
//   submitFeedback({
//     required String category,
//     String? message,
//     List<File>? attachments,
//     String? username,
//     String? email,
//   }) async {
//     try {
//       const path = 'feedback/submit/';

//       final formData = FormData();

//       formData.fields.add(MapEntry('category', category));

//       if (message != null && message.isNotEmpty) {
//         formData.fields.add(MapEntry('message', message));
//       }

//       if (username != null && username.isNotEmpty) {
//         formData.fields.add(MapEntry('username', username));
//       }

//       if (email != null && email.isNotEmpty) {
//         formData.fields.add(MapEntry('email', email));
//       }

//       if (attachments != null && attachments.isNotEmpty) {
//         kLogs('Adding ${attachments.length} attachments');
//         for (final attachment in attachments) {
//           final fileSize = await attachment.length();
//           final sizeInMB = fileSize / (1024 * 1024);
//           kLogs(
//             'Attachment: ${attachment.path.split('/').last},'
//             ' Size: ${sizeInMB.toStringAsFixed(2)}MB',
//           );

//           final fileUpload = await MultipartFile.fromFile(
//             attachment.path,
//             filename: attachment.path.split('/').last,
//           );
//           formData.files.add(
//             MapEntry(
//               'attachments',
//               fileUpload,
//             ),
//           );
//         }
//       }

//       kLogs('Submitting feedback with form data: ${formData.fields}');
//       kLogs('Total files: ${formData.files.length}');

//       final response = await postRequest(
//         path,
//         data: formData,
//       );

//       kLogs('Feedback submission response: ${response.data}');

//       final responseData = response.data as Map<String, dynamic>? ?? {};
//       final nestedData = responseData['data'] as Map<String, dynamic>?;

//       kLogs('Nested data from feedback: $nestedData');

//       return (
//         statusCode: response.statusCode ?? 0,
//         data: responseData,
//         errorMessage: null,
//       );
//     } catch (e) {
//       kLogs('Error submitting feedback: $e');
//       return (
//         statusCode: null,
//         data: null,
//         errorMessage: handleDioError(e),
//       );
//     }
//   }
// }
