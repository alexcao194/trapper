import '../generated/l10n.dart';

class Validator {
  static String? email(String value) {
    if (value.isEmpty) {
      return null;
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return S.current.email_invalid;
    }
    return null;
  }

  static String? password(String password, {String? checker}) {
    if (password.isEmpty) {
      return null;
    }
    if (password.length < 6) {
      return S.current.password_length_error;
    }
    if (checker != null && password != checker) {
      return S.current.confirm_password_not_match;
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

  static String? otp(String value) {
    if (value.isEmpty) {
      return S.current.otp_required;
    }
    if (int.tryParse(value) == null) {
      return S.current.otp_must_be_number;
    }
    if (value.length != 6) {
      return S.current.otp_length_error;
    }
    return null;
  }
}