import 'package:cosmetic_app/constants/errors/error_constants.dart';

/// Valida los campos vacíos de los formularios
String? fieldValidator(String? value, {RegExp? regExp, String errorMessage = invalidFormatError}) {
  if (value == null || value.trim().isEmpty) return requiredFieldError;

  if (regExp != null && !regExp.hasMatch(value)) return errorMessage;

  return null;
}
