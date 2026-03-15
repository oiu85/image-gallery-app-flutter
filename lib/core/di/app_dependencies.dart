import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/auth_repository.dart';
import '../network/network_client.dart';
import '../storage/app_storage_service.dart';

final getIt = GetIt.instance;

//* Configure and initialize all dependencies.
//! This must be called after WidgetsFlutterBinding.ensureInitialized()

Future<GetIt> configureDependencies() async {
  // Initialize SharedPreferences first
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<AppStorageService>(
    () => SharedPreferencesStorageService(getIt<SharedPreferences>()),
  );

  getIt.registerSingleton<NetworkClient>(
    NetworkClient(getIt<AppStorageService>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AppStorageService>()),
  );

  return getIt;
}
