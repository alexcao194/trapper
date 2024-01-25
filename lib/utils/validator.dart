import '../generated/l10n.dart';

class Validator {
  static String? email(String value) {
    if (value.isEmpty) {
      return S.current.email_required;
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return S.current.email_invalid;
    }
    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) {
      return S.current.password_required;
    }
    if (value.length < 6) {
      return S.current.password_length_error;
    }
    return null;
  }

  static String? confirmPassword(String value, String password) {
    if (value.isEmpty) {
      return S.current.confirm_password_required;
    }
    if (value != password) {
      return S.current.confirm_password_not_match;
    }
    return null;
  }

  static String? name(String value) {
    if (value.isEmpty) {
      return S.current.full_name_required;
    }
    return null;
  }
}