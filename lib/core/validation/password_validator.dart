import 'package:reactive_forms/reactive_forms.dart';

/// Validator for password field
///
/// Validates that:
/// - Password is not empty
/// - Password length is within [minLength] and [maxLength]
/// - Optional: uppercase, lowercase, number, special char
class PasswordValidator {
  final int minLength;
  final int? maxLength;
  final bool requireUpperCase;
  final bool requireLowerCase;
  final bool requireNumber;
  final bool requireSpecialChar;

  const PasswordValidator({
    this.minLength = 8,
    this.maxLength,
    this.requireUpperCase = false,
    this.requireLowerCase = false,
    this.requireNumber = false,
    this.requireSpecialChar = false,
  });

  /// Validate for standard Form (returns String? for error message)
  String? call(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    final password = value;

    if (password.length < minLength) {
      return 'Minimum $minLength characters';
    }

    if (maxLength != null && password.length > maxLength!) {
      return 'Maximum $maxLength characters';
    }

    if (requireUpperCase && !password.contains(RegExp(r'[A-Z]'))) {
      return 'Requires at least one uppercase letter';
    }

    if (requireLowerCase && !password.contains(RegExp(r'[a-z]'))) {
      return 'Requires at least one lowercase letter';
    }

    if (requireNumber && !password.contains(RegExp(r'[0-9]'))) {
      return 'Requires at least one number';
    }

    if (requireSpecialChar && !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Requires at least one special character';
    }

    return null;
  }

  /// Validate for reactive_forms (returns Map<String, dynamic>?)
  Map<String, dynamic>? reactive(AbstractControl<dynamic> control) {
    final error = call(control.value?.toString());
    return error != null ? {'password': error} : null;
  }

  /// Legacy method for backward compatibility
  PasswordValidationResult resolve(Object? value) {
    final error = call(value?.toString());
    return PasswordValidationResult(error);
  }

  /// Get password strength (weak, medium, strong)
  static PasswordStrength getPasswordStrength(String password) {
    if (password.isEmpty) return PasswordStrength.empty;
    if (password.length < 6) return PasswordStrength.weak;

    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    if (strength <= 2) return PasswordStrength.weak;
    if (strength <= 4) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }
}

/// Result wrapper for legacy compatibility
class PasswordValidationResult {
  final String? message;

  const PasswordValidationResult(this.message);
}

enum PasswordStrength { empty, weak, medium, strong }
