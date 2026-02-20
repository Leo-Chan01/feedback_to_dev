import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

String handleDioError(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond.';
      case DioExceptionType.sendTimeout:
        return 'Request took too long. Please check your network.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        String? serverMessage;

        // Safely extract server message
        final responseData = error.response?.data;
        if (responseData is Map<String, dynamic>) {
          serverMessage = responseData['message'] as String?;
        } else if (responseData is String) {
          serverMessage = responseData;
        }

        switch (statusCode) {
          case 400:
            return serverMessage ?? 'Bad request. Please check your input.';
          case 401:
            return serverMessage ?? 'Unauthorized. Please log in again.';
          case 403:
            return serverMessage ??
                "Forbidden. You don't have permission to access this resource";
          case 404:
            return serverMessage ?? 'Requested resource not found.';
          case 409:
            return serverMessage ??
                'Conflict detected. The requested action cannot be performed.';
          case 500:
            return serverMessage ?? 'Server error. Please try again later.';
          case 522:
            return serverMessage ??
                'Server connection failed. Please check your internet'
                    ' connection and try again.';
          default:
            return serverMessage ??
                'Unexpected error occurred. Status code: $statusCode';
        }
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'An unknown error occurred.';
      case DioExceptionType.badCertificate:
        return 'Bad certificate.';
      case DioExceptionType.connectionError:
        return 'Connection error.';
    }
  } else if (error is SocketException) {
    return 'No Internet connection. Please check your network.';
  } else if (error is TimeoutException) {
    return 'Request timed out. Try again later.';
  } else if (error is FormatException) {
    return 'Invalid response format. Please try again later.';
  } else {
    return 'Unexpected error socket: $error';
  }
}
