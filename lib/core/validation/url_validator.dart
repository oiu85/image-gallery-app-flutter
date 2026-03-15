import 'package:easy_localization/easy_localization.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../localization/locale_keys.g.dart';

/// Validator for URL fields (e.g. YouTube trailer link).
///
/// Validates that:
/// - Empty is allowed (optional field)
/// - If provided, must be a valid URL format
class UrlValidator {
  const UrlValidator();

  /// Validate for standard Form (returns String? for error message)
  String? call(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final trimmed = value.trim();
    final uri = Uri.tryParse(trimmed);

    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return LocaleKeys.validation_urlInvalid.tr();
    }

    final scheme = uri.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https') {
      return LocaleKeys.validation_urlInvalid.tr();
    }

    return null;
  }

  /// Validate for reactive_forms (returns Map<String, dynamic>?)
  Map<String, dynamic>? reactive(AbstractControl<dynamic> control) {
    final error = call(control.value?.toString());
    return error != null ? {'url': error} : null;
  }

  /// Static helper to check if a string is a valid URL
  static bool isValidUrl(String? value) {
    if (value == null || value.trim().isEmpty) return false;
    final uri = Uri.tryParse(value.trim());
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) return false;
    final scheme = uri.scheme.toLowerCase();
    return scheme == 'http' || scheme == 'https';
  }
}
