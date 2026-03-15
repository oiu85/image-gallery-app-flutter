import 'package:easy_localization/easy_localization.dart';

import '../localization/locale_keys.g.dart';

/// Validator for required (non-empty) fields.
class RequiredValidator {
  const RequiredValidator({this.messageKey});

  /// Locale key for error message; defaults to [LocaleKeys.validation_required].
  final String? messageKey;

  String? call(String? value) {
    if (value == null || value.trim().isEmpty) {
      return (messageKey ?? LocaleKeys.validation_required).tr();
    }
    return null;
  }
}
