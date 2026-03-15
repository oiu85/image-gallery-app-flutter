import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/validation/form_validators.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginFormState {
  const LoginFormState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isLoading = false,
    this.isSuccess = false,
  });

  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isLoading;
  final bool isSuccess;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email.trim().isNotEmpty &&
      password.isNotEmpty;

  LoginFormState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class LoginViewModel extends StateNotifier<LoginFormState> {
  LoginViewModel(this._authRepository) : super(const LoginFormState());

  final AuthRepository _authRepository;

  static const _emailValidator = EmailValidator();
  static const _passwordValidator =
      PasswordValidator(minLength: 6, maxLength: 12);

  void setEmail(String value) {
    final error = _emailValidator(value);
    state = state.copyWith(email: value, emailError: error);
  }

  void setPassword(String value) {
    final error = _passwordValidator(value);
    state = state.copyWith(password: value, passwordError: error);
  }

  void validateAll() {
    state = state.copyWith(
      emailError: _emailValidator(state.email),
      passwordError: _passwordValidator(state.password),
    );
  }

  Future<void> login() async {
    validateAll();
    if (!state.isFormValid) return;

    state = state.copyWith(isLoading: true, isSuccess: false);
    try {
      final success = await _authRepository.login(
        email: state.email.trim(),
        password: state.password,
      );
      state = state.copyWith(isLoading: false, isSuccess: success);
    } catch (_) {
      state = state.copyWith(isLoading: false, isSuccess: false);
    }
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginFormState>((ref) {
  return LoginViewModel(getIt<AuthRepository>());
});
