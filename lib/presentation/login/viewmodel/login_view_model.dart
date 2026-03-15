import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/validation/form_validators.dart';
import '../../../data/repositories/auth_repository.dart';

/// Form state for the login screen.
class LoginFormState {
  const LoginFormState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isLoading = false,
  });

  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isLoading;

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
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Login ViewModel using Riverpod.
class LoginViewModel extends StateNotifier<LoginFormState> {
  LoginViewModel(this._authRepository) : super(const LoginFormState());

  final AuthRepository _authRepository;

  static const _emailValidator = EmailValidator();
  static const _passwordValidator = PasswordValidator(minLength: 6, maxLength: 12);

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

  Future<bool> login() async {
    validateAll();
    if (!state.isFormValid) return false;

    state = state.copyWith(isLoading: true);
    try {
      // Mock login: check if user is registered, simulate success
      final isRegistered = await _authRepository.isRegistered();
      if (!isRegistered) {
        state = state.copyWith(isLoading: false);
        return false;
      }
      return true;
    } catch (_) {
      state = state.copyWith(isLoading: false);
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginFormState>((ref) {
  return LoginViewModel(getIt<AuthRepository>());
});
