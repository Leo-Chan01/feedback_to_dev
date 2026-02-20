import 'dart:developer';

import 'package:feedback_to_vfd/core/error/provider_error_handling_mixin.dart';
import 'package:feedback_to_vfd/core/utils/app_routes.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';
import 'package:feedback_to_vfd/features/users/domain/repostitory/auth_repository.dart';
import 'package:feedback_to_vfd/features/users/domain/usecases/user_login_usecase.dart';
import 'package:feedback_to_vfd/features/users/presentation/screens/login_screen.dart';
import 'package:feedback_to_vfd/injection_container.dart';
import 'package:feedback_to_vfd/shared/widgets/global_snackbar.dart';

class AuthProvider extends ChangeNotifier with ProviderErrorHandling {
  AuthProvider({required this.loginUserUsecase});

  final UserLoginUsecase loginUserUsecase;

  UserEntity? _currentUser;
  UserEntity? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> initializeAuth() async {
    final response = await sl<AuthRepository>().initializeAuth();
    response.fold(
      (error) => log('Auth initialization error: ${error.message}'),
      (user) {
        if (user != null) {
          _currentUser = user;
          notifyListeners();
        }
      },
    );
  }

  Future<void> logout() async {
    await sl<AuthRepository>().logout();
    _currentUser = null;
    notifyListeners();
    AppRoutes.router.goNamed(LoginScreen.name);
  }

  Future<void> logIn(String accessId) async {
    _isLoading = true;
    notifyListeners();

    final response = await loginUserUsecase.call(accessId);

    _isLoading = false;
    response.fold(
      (error) {
        GlobalSnackBar.showError(error.message);
        notifyListeners();
      },
      (data) {
        _currentUser = data;
        AppRoutes.router.goNamed(DashboardScreen.name);
        notifyListeners();
      },
    );
  }
}
