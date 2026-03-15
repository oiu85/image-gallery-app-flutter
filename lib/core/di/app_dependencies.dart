import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasource/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/gallery/data/datasource/pixabay_api_service.dart';
import '../../features/gallery/data/repositories/image_repository_impl.dart';
import '../../features/gallery/domain/repositories/image_repository.dart';
import '../network/network_client.dart';
import '../storage/app_storage_service.dart';

final getIt = GetIt.instance;

Future<GetIt> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<AppStorageService>(
    () => SharedPreferencesStorageService(getIt<SharedPreferences>()),
  );

  getIt.registerSingleton<NetworkClient>(
    NetworkClient(getIt<AppStorageService>()),
  );

  // Auth
  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasource(getIt<AppStorageService>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthLocalDatasource>()),
  );

  // Gallery
  getIt.registerLazySingleton<PixabayApiService>(
    () => PixabayApiService(),
  );
  getIt.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(getIt<PixabayApiService>()),
  );

  return getIt;
}
