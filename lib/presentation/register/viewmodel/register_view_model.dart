import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/validation/form_validators.dart';
import '../../../data/repositories/auth_repository.dart';

/// Form state for the register screen.
class RegisterFormState {
  const RegisterFormState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.age = '',
    this.usernameError,
    this.emailError,
    this.passwordError,
    this.ageError,
    this.isLoading = false,
  });

  final String username;
  final String email;
  final String password;
  final String age;
  final String? usernameError;
  final String? emailError;
  final String? passwordError;
  final String? ageError;
  final bool isLoading;

  bool get isFormValid =>
      usernameError == null &&
      emailError == null &&
      passwordError == null &&
      ageError == null &&
      username.trim().isNotEmpty &&
      email.trim().isNotEmpty &&
      password.isNotEmpty &&
      age.trim().isNotEmpty;

  RegisterFormState copyWith({
    String? username,
    String? email,
    String? password,
    String? age,
    String? usernameError,
    String? emailError,
    String? passwordError,
    String? ageError,
    bool? isLoading,
  }) {
    return RegisterFormState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      age: age ?? this.age,
      usernameError: usernameError,
      emailError: emailError,
      passwordError: passwordError,
      ageError: ageError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Register ViewModel using Riverpod.
class RegisterViewModel extends StateNotifier<RegisterFormState> {
  RegisterViewModel(this._authRepository) : super(const RegisterFormState());

  final AuthRepository _authRepository;

  static const _usernameValidator = UsernameValidator(minLength: 3, maxLength: 12);
  static const _emailValidator = EmailValidator();
  static const _passwordValidator = PasswordValidator(minLength: 6, maxLength: 12);
  static const _ageValidator = AgeValidator(minAge: 18, maxAge: 99);

  void setUsername(String value) {
    final error = _usernameValidator(value);
    state = state.copyWith(username: value, usernameError: error);
  }

  void setEmail(String value) {
    final error = _emailValidator(value);
    state = state.copyWith(email: value, emailError: error);
  }

  void setPassword(String value) {
    final error = _passwordValidator(value);
    state = state.copyWith(password: value, passwordError: error);
  }

  void setAge(String value) {
    final error = _ageValidator(value);
    state = state.copyWith(age: value, ageError: error);
  }

  void validateAll() {
    state = state.copyWith(
      usernameError: _usernameValidator(state.username),
      emailError: _emailValidator(state.email),
      passwordError: _passwordValidator(state.password),
      ageError: _ageValidator(state.age),
    );
  }

  Future<bool> register() async {
    validateAll();
    if (!state.isFormValid) return false;

    state = state.copyWith(isLoading: true);
    try {
      await _authRepository.register(
        username: state.username.trim(),
        email: state.email.trim(),
        password: state.password,
        age: int.parse(state.age.trim()),
      );
      return true;
    } catch (_) {
      state = state.copyWith(isLoading: false);
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final registerViewModelProvider = StateNotifierProvider<RegisterViewModel, RegisterFormState>((ref) {
  return RegisterViewModel(getIt<AuthRepository>());
});
