library;

export 'age_validator.dart';
export 'email_validator.dart';
export 'password_validator.dart';
export 'required_validator.dart';
export 'username_validator.dart';

/// Common validation utilities
class ValidationUtils {
  /// Check if a string is empty or null
  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Check if a string contains only digits
  static bool isDigitsOnly(String value) {
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  /// Check if a string contains only letters and spaces
  static bool isLettersAndSpacesOnly(String value) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(value);
  }

  /// Check if a string contains only Arabic letters and spaces
  static bool isArabicLettersAndSpacesOnly(String value) {
    return RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(value);
  }

  /// Remove all non-digit characters from a string
  static String removeNonDigits(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Remove all spaces and dashes from a string
  static String removeSpacesAndDashes(String value) {
    return value.replaceAll(RegExp(r'[\s\-]'), '');
  }
}
