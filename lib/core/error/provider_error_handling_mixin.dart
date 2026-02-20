import 'package:feedback_to_vfd/core/error/error_handler.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/shared/widgets/global_snackbar.dart';
import 'package:flutter/foundation.dart';

mixin ProviderErrorHandling on ChangeNotifier {
  String? _errorMessage;
  bool _isLoading = false;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  bool get hasError => _errorMessage != null;

  void setLoading({required bool loading}) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error, {bool showSnackbar = true}) {
    _errorMessage = error;
    if (error != null && showSnackbar) {
      GlobalSnackBar.showError(error);
    }
    notifyListeners();
  }

  void setErrorFromFailure(Failure failure, {bool showSnackbar = true}) {
    final userMessage = ErrorHandler.getUserFriendlyMessage(failure);
    setError(userMessage, showSnackbar: showSnackbar);
    ErrorHandler.logError(
      failure,
      context: runtimeType.toString(),
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<T?> handleAsyncOperation<T>({
    required Future<T> Function() operation,
    String? errorContext,
    bool showLoading = true,
    bool showErrorSnackbar = true,
    void Function(T result)? onSuccess,
    void Function(Failure failure)? onError,
  }) async {
    if (showLoading) setLoading(loading: true);
    clearError();

    try {
      final result = await operation();
      onSuccess?.call(result);
      return result;
    } catch (e, stackTrace) {
      final failure = ErrorHandler.handleException(e, stackTrace);

      ErrorHandler.logError(
        e,
        stackTrace: stackTrace,
        context: errorContext ?? runtimeType.toString(),
      );

      setErrorFromFailure(failure, showSnackbar: showErrorSnackbar);
      onError?.call(failure);
      return null;
    } finally {
      if (showLoading) setLoading(loading: false);
    }
  }

  void showSuccess(String message) {
    GlobalSnackBar.showSuccess(message);
  }

  void showWarning(String message) {
    GlobalSnackBar.showWarning(message);
  }

  void showInfo(String message) {
    GlobalSnackBar.showInfo(message);
  }

  void resetErrorState() {
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
