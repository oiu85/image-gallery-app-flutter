import 'package:reactive_forms/reactive_forms.dart';

/// Validator for age field.
///
/// Validates that:
/// - Age is not empty
/// - Age is a valid number
/// - Age is within [minAge] and [maxAge] range
class AgeValidator {
  final int minAge;
  final int maxAge;

  const AgeValidator({this.minAge = 18, this.maxAge = 99});

  /// Validate for standard Form (returns String? for error message)
  String? call(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }

    final n = int.tryParse(value.trim());
    if (n == null) {
      return 'Must be a number';
    }
    if (n < minAge || n > maxAge) {
      return 'Age must be between $minAge and $maxAge';
    }
    return null;
  }

  /// Validate for reactive_forms
  Map<String, dynamic>? reactive(AbstractControl<dynamic> control) {
    final error = call(control.value?.toString());
    return error != null ? {'age': error} : null;
  }

  /// Static helper to validate age
  static bool isValidAge(String value, {int minAge = 18, int maxAge = 99}) {
    final n = int.tryParse(value.trim());
    return n != null && n >= minAge && n <= maxAge;
  }
}
