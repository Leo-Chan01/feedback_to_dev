import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/screen/feedback_form_screen.dart';
import 'package:feedback_to_vfd/features/main/presentation/screen/main_screen.dart';
import 'package:feedback_to_vfd/features/onboarding/splash_screen.dart';
import 'package:feedback_to_vfd/features/users/presentation/screens/login_screen.dart';
import 'package:feedback_to_vfd/features/projects/presentation/screens/projects_screen.dart';
import 'package:feedback_to_vfd/features/users/presentation/screens/profile_screen.dart';

class AppRoutes {
  static String splashRoute = '/';
  static String dashboardRoute = '/dashboard';
  static String projectsRoute = '/projects';
  static String feedbackRoute = '/feedback';
  static String profileRoute = '/profile';

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.splashRoute,
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splashRoute,
        builder: (context, state) => SplashScreen(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: LoginScreen.path,
        name: LoginScreen.name,
        builder: (context, state) {
          return LoginScreen(key: state.pageKey);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            key: state.pageKey,
            shell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dashboardRoute,
                name: DashboardScreen.name,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.projectsRoute,
                name: 'Projects',
                builder: (context, state) => const ProjectsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.feedbackRoute,
                name: FeedbackFormScreen.name,
                builder: (context, state) => const FeedbackFormScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profileRoute,
                name: 'Profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
