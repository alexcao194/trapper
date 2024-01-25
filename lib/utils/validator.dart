class Validator {
  static String? email(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Email must be valid';
    }
    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? confirmPassword(String value, String password) {
    if (value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != password) {
      return 'Confirm Password must be same as Password';
    }
    return null;
  }

  static String? name(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }
}