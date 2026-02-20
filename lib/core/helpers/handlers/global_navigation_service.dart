import 'package:go_router/go_router.dart';

class GlobalNavigationService {
  GlobalNavigationService._internal();
  static final GlobalNavigationService instance =
      GlobalNavigationService._internal();

  late GoRouter _router;

  // ignore: use_setters_to_change_properties
  void setRouter(GoRouter router) {
    _router = router;
  }

  void navigateToLogin() {
    _router.go('/login'); // Replace '/login' with your login route path
  }
}
