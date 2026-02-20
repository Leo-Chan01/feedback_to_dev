import 'dart:developer' as dev;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feedback_to_vfd/core/utils/exceptions.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';

class ErrorHandler {
  ErrorHandler._();

  static Failure handleException(Object exception, [StackTrace? stackTrace]) {
    dev.log(
      'Error occurred: $exception',
      name: 'ErrorHandler',
      error: exception,
      stackTrace: stackTrace,
    );

    if (exception is DioException) {
      return _handleDioException(exception);
    } else if (exception is ServerException) {
      return ServerFailure(
        message: exception.message,
        code: int.tryParse(exception.statusCode),
      );
    } else if (exception is NetworkException) {
      return NetworkFailure(
        message: exception.message,
        code: int.tryParse(exception.statusCode),
      );
    } else if (exception is CacheException) {
      return CacheFailure(
        message: exception.message,
        code: int.tryParse(exception.statusCode),
      );
    } else if (exception is SocketException) {
      return const NetworkFailure(
        message: 'No internet connection. Please check your network.',
      );
    } else if (exception is FormatException) {
      return ValidationFailure(
        message: exception.message,
      );
    } else {
      return ServerFailure(
        message: exception.toString(),
      );
    }
  }

  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          message:
              'Request timeout. '
              'Please check your internet connection and try again.',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);

      case DioExceptionType.cancel:
        return const ServerFailure(
          message: 'Request was cancelled',
        );

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (exception.error is SocketException) {
          return const NetworkFailure(
            message: 'No internet connection. Please check your network.',
          );
        }
        return ServerFailure(
          message: exception.message ?? 'An unexpected error occurred',
        );

      case DioExceptionType.badCertificate:
        return const ServerFailure(
          message: 'Security certificate error. Please try again later.',
        );
    }
  }

  static Failure _handleBadResponse(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final data = exception.response?.data;

    var errorMessage = 'An error occurred';

    if (data is Map) {
      errorMessage =
          data['message'] as String? ??
          data['error'] as String? ??
          data['detail'] as String? ??
          errorMessage;
    } else if (data is String) {
      errorMessage = data;
    }

    switch (statusCode) {
      case 400:
        return ValidationFailure(
          message: errorMessage.isEmpty
              ? 'Invalid request. Please check your input.'
              : errorMessage,
          code: statusCode,
        );

      case 401:
        return AuthFailure(
          message: errorMessage.isEmpty
              ? 'You are unauthorized. Please verify your code.'
              : errorMessage,
          code: statusCode,
        );

      case 403:
        return PermissionFailure(
          message: errorMessage.isEmpty
              ? 'You do not have permission to perform this action.'
              : errorMessage,
          code: statusCode,
        );

      case 404:
        return ServerFailure(
          message: errorMessage.isEmpty ? 'Resource not found' : errorMessage,
          code: statusCode,
        );

      case 409:
        return ValidationFailure(
          message: errorMessage.isEmpty
              ? 'This resource already exists or conflicts with existing data.'
              : errorMessage,
          code: statusCode,
        );

      case 422:
        return ValidationFailure(
          message: errorMessage.isEmpty
              ? 'Invalid data submitted. Please check and try again.'
              : errorMessage,
          code: statusCode,
        );

      case 429:
        return ServerFailure(
          message: 'Too many requests. Please wait and try again.',
          code: statusCode,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          message: 'Server error. Please try again later.',
          code: statusCode,
        );

      default:
        return ServerFailure(
          message: errorMessage.isEmpty
              ? 'An unexpected error occurred'
              : errorMessage,
          code: statusCode,
        );
    }
  }

  static String getUserFriendlyMessage(Failure failure) {
    final message = failure.message.toLowerCase();

    if (message.contains('timeout')) {
      return 'Request timed out. Please check your internet connection '
          'and try again.';
    }

    if (message.contains('connection') || message.contains('network')) {
      return 'Unable to connect to server. '
          'Please check your internet connection.';
    }

    if (message.contains('token') || message.contains('unauthorized')) {
      return 'You are unauthorized. Please verify your access code.';
    }
    if (message.contains('apple authorization code') ||
        (message.contains('apple') && message.contains('required'))) {
      return 'Apple sign-in is currently unavailable. '
          'Please try again later or use a different sign-in method.';
    }

    if (message.contains('google') &&
        (message.contains('required') || message.contains('invalid'))) {
      return 'Google sign-in is currently unavailable. '
          'Please try again later or use a different sign-in method.';
    }

    if (message.contains('type') &&
        (message.contains('subtype') || message.contains('cast'))) {
      return 'The server is currently experiencing issues. '
          'Please try again in a few moments.';
    }

    if (message.contains('validation') || message.contains('invalid')) {
      return failure.message;
    }
    if (failure.code == 500 || message.contains('internal server error')) {
      return 'Server error occurred. Please try again later.';
    }
    return failure.message;
  }

  static bool requiresReAuth(Failure failure) {
    if (failure is AuthFailure) return true;

    final message = failure.message.toLowerCase();
    return message.contains('token') ||
        message.contains('unauthorized') ||
        message.contains('session expired') ||
        failure.code == 401;
  }

  static bool isNetworkError(Failure failure) {
    if (failure is NetworkFailure) return true;

    final message = failure.message.toLowerCase();
    return message.contains('network') ||
        message.contains('connection') ||
        message.contains('internet') ||
        message.contains('timeout');
  }

  static bool isRetryable(Failure failure) {
    if (failure.code != null && failure.code! >= 500 && failure.code! < 600) {
      return true;
    }

    if (failure.message.toLowerCase().contains('timeout')) return true;

    return false;
  }

  static void logError(
    Object error, {
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalData,
  }) {
    dev.log(
      'Error${context != null ? ' in $context' : ''}: $error',
      name: 'ErrorHandler',
      error: error,
      stackTrace: stackTrace,
    );

    if (additionalData != null && additionalData.isNotEmpty) {
      dev.log(
        'Additional data: $additionalData',
        name: 'ErrorHandler',
      );
    }
  }
}
