import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._localDatasource);

  final AuthLocalDatasource _localDatasource;

  @override
  Future<User> register({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final user = UserModel(username: username, email: email, age: age);
    await _localDatasource.saveUser(user);
    return user;
  }

  @override
  Future<bool> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _localDatasource.isRegistered();
  }

  @override
  Future<bool> isRegistered() => _localDatasource.isRegistered();

  @override
  Future<User?> getRegisteredUser() => _localDatasource.getUser();
}
