import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

class AppRouter {
  /// Creates and returns the router; initial route is [AppRoutes.login].
  static Future<GoRouter> createRouter() async {
    return GoRouter(
      initialLocation: AppRoutes.login,
      debugLogDiagnostics: kDebugMode,
      routes: [

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
