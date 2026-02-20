import 'package:feedback_to_vfd/core/error/provider_error_handling_mixin.dart';
import 'package:feedback_to_vfd/core/utils/app_routes.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';
import 'package:feedback_to_vfd/features/users/domain/usecases/user_login_usecase.dart';
import 'package:feedback_to_vfd/shared/widgets/global_snackbar.dart';

class AuthProvider extends ChangeNotifier with ProviderErrorHandling {
  AuthProvider({required this.loginUserUsecase});

  final UserLoginUsecase loginUserUsecase;

  UserEntity? _currentUser;
  UserEntity? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
