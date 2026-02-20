import 'package:feedback_to_vfd/core/utils/app_routes.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:feedback_to_vfd/features/projects/presentation/provider/projects_provider.dart';
import 'package:feedback_to_vfd/injection_container.dart';
import 'package:feedback_to_vfd/l10n/l10n.dart';
import 'package:feedback_to_vfd/shared/configs/theme.dart';
import 'package:feedback_to_vfd/shared/widgets/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ProjectsProvider>()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                useInheritedMediaQuery: true,
                ensureScreenSize: true,
                rebuildFactor: (old, data) => true,
                builder: (context, child) {
                  return MaterialApp.router(
                    title: 'Feedback to YFD',
                    scaffoldMessengerKey: GlobalSnackBar.scaffoldMessengerKey,
                    theme: AppTheme.instance.darkTheme,
                    themeMode: ThemeMode.dark,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    routerConfig: AppRoutes.router,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
