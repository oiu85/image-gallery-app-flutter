import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> register({
    required String username,
    required String email,
    required String password,
    required int age,
  });

  Future<bool> login({
    required String email,
    required String password,
  });

  Future<bool> isRegistered();

  Future<User?> getRegisteredUser();
}
