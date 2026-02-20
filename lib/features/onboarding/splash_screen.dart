import 'dart:async';

import 'package:feedback_to_vfd/core/utils/app_routes.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:feedback_to_vfd/features/users/presentation/screens/login_screen.dart';
import 'package:feedback_to_vfd/injection_container.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authProvider = sl<AuthProvider>();
    await authProvider.initializeAuth();

    if (mounted) {
      if (authProvider.currentUser != null) {
        unawaited(AppRoutes.router.replaceNamed(DashboardScreen.name));
      } else {
        unawaited(AppRoutes.router.replaceNamed(LoginScreen.name));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            FlutterLogo(
              size: 50,
            ),
            // Text('Splash Screen'),
          ],
        ),
      ),
    );
  }
}
