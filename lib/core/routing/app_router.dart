import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/gallery/data/models/pixabay_image.dart';
import '../../features/gallery/presentation/screens/home_screen.dart';
import '../../features/image_detail/presentation/screens/image_detail_screen.dart';
import '../di/app_dependencies.dart';
import '../storage/app_storage_service.dart';
import 'app_routes.dart';

class AppRouter {
  static Future<GoRouter> createRouter() async {
    final storage = getIt<AppStorageService>();
    final isRegistered = await storage.isRegistered();

    return GoRouter(
      initialLocation: isRegistered ? AppRoutes.home : AppRoutes.register,
      debugLogDiagnostics: kDebugMode,
      routes: [
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.imageDetail,
          builder: (context, state) {
            final image = state.extra! as PixabayImage;
            return ImageDetailScreen(image: image);
          },
        ),
      ],
    );
  }

  static GoRouter? _router;

  static Future<void> initialize() async {
    _router = await createRouter();
  }

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
