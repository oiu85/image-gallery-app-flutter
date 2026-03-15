import 'dart:convert';

import '../models/registered_user.dart';
import '../../core/di/app_dependencies.dart';
import '../../core/storage/app_storage_service.dart';

/// Mock auth repository that simulates register API and stores user locally.
class AuthRepository {
  AuthRepository([AppStorageService? storage])
      : _storage = storage ?? getIt<AppStorageService>();

  final AppStorageService _storage;

  /// Mock register: simulates API call and saves user to SharedPreferences.
  Future<RegisteredUser> register({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final user = RegisteredUser(
      username: username,
      email: email,
      age: age,
    );

    await _storage.saveRegisteredUser(jsonEncode(user.toJson()));
    await _storage.setUserName(username);
    await _storage.setUserEmail(email);
    await _storage.setUserAge(age);
    await _storage.setRegistered(true);
    await _storage.setAccessToken(
      'mock_token_${username}_${DateTime.now().millisecondsSinceEpoch}',
    );

    return user;
  }

  /// Check if a user is already registered locally.
  Future<bool> isRegistered() => _storage.isRegistered();

  /// Load the registered user from local storage.
  Future<RegisteredUser?> getRegisteredUser() async {
    final json = await _storage.getRegisteredUser();
    if (json == null) return null;
    return RegisteredUser.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
}
