import 'package:easy_localization/easy_localization.dart';

import '../localization/locale_keys.g.dart';
import 'url_validator.dart';

/// Validator for required URL fields (e.g. trailer link).
///
/// Validates that:
/// - Field is not empty (required)
/// - If provided, must be a valid URL format
class RequiredUrlValidator {
  const RequiredUrlValidator({this.messageKey});

  /// Locale key for required error; defaults to [LocaleKeys.validation_trailerUrlRequired].
  final String? messageKey;

  String? call(String? value) {
    //* Required check first
    if (value == null || value.trim().isEmpty) {
      return (messageKey ?? LocaleKeys.validation_trailerUrlRequired).tr();
    }
    //* URL format check
    return const UrlValidator().call(value);
  }
}
