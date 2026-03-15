import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../../presentation/home/home_page.dart';
import '../../presentation/login/pages/login_page.dart';
import '../../presentation/register/pages/register_page.dart';

class AppRouter {
  /// Creates and returns the router; initial route is [AppRoutes.register].
  static Future<GoRouter> createRouter() async {
    return GoRouter(
      initialLocation: AppRoutes.register,
      debugLogDiagnostics: kDebugMode,
      routes: [
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
      ],
    );
  }

  /// Static router instance - initialized after dependencies are ready.
  static GoRouter? _router;
  
  /// Initialize the router - must be called after configureDependencies().
  static Future<void> initialize() async {
    _router = await createRouter();
  }
  
  /// Get the router instance.
  /// Throws if router is not initialized.
  static GoRouter get router {
    if (_router == null) {
      throw StateError(
        'AppRouter.router accessed before initialization. '
        'Call AppRouter.initialize() first.',
      );
    }
    return _router!;
  }
}
