import 'dart:convert';

import '../../../../core/storage/app_storage_service.dart';
import '../models/user_model.dart';

class AuthLocalDatasource {
  const AuthLocalDatasource(this._storage);

  final AppStorageService _storage;

  Future<void> saveUser(UserModel user) async {
    await _storage.saveRegisteredUser(jsonEncode(user.toJson()));
    await _storage.setUserName(user.username);
    await _storage.setUserEmail(user.email);
    await _storage.setUserAge(user.age);
    await _storage.setRegistered(true);
    await _storage.setAccessToken('mock_token_${user.username}_${DateTime.now().millisecondsSinceEpoch}');
  }

  Future<bool> isRegistered() => _storage.isRegistered();

  Future<UserModel?> getUser() async {
    final json = await _storage.getRegisteredUser();
    if (json == null) return null;
    return UserModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
}
