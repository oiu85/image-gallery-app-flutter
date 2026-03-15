/// Validator for required (non-empty) fields.
class RequiredValidator {
  const RequiredValidator({this.message = 'This field is required'});

  final String message;

  String? call(String? value) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}
