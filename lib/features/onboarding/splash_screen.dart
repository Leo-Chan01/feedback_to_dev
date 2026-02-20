import 'dart:async';

import 'package:feedback_to_vfd/core/utils/app_routes.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/users/presentation/screens/login_screen.dart';
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
    Future.delayed(const Duration(seconds: 2), () async {
      unawaited(AppRoutes.router.replaceNamed(LoginScreen.name));
    });
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
