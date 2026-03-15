import 'package:reactive_forms/reactive_forms.dart';

/// Validator for username field.
///
/// Validates that:
/// - Username is not empty
/// - Username is between [minLength] and [maxLength] characters
class UsernameValidator {
  final int minLength;
  final int maxLength;

  const UsernameValidator({this.minLength = 3, this.maxLength = 12});

  /// Validate for standard Form (returns String? for error message)
  String? call(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }

    final v = value.trim();
    if (v.length < minLength) {
      return 'Minimum $minLength characters';
    }
    if (v.length > maxLength) {
      return 'Maximum $maxLength characters';
    }
    return null;
  }

  /// Validate for reactive_forms
  Map<String, dynamic>? reactive(AbstractControl<dynamic> control) {
    final error = call(control.value?.toString());
    return error != null ? {'username': error} : null;
  }

  /// Static helper to validate username
  static bool isValidUsername(String username, {int minLength = 3, int maxLength = 12}) {
    final v = username.trim();
    return v.isNotEmpty && v.length >= minLength && v.length <= maxLength;
  }
}
