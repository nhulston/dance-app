class Validation {
  static bool hasSpecialChar(String s) {
    return RegExp('[ !#\$%^&*()+=\\[\\],?"\\\'/:{}|\\\\<>]').hasMatch(s);
  }
  
  static bool hasAtOrDot(String s) {
    return RegExp('[@.]').hasMatch(s);
  }

  static bool emailValidator(String? s) {
    if (s == null || s.isEmpty || s.length < 6 || !s.contains('@') || !s.contains('.') || hasSpecialChar(s)) {
      return false;
    }
    return true;
  }
  
  static bool usernameValidator(String? s) {
    if (s == null || s.length < 3 || hasSpecialChar(s) || hasAtOrDot(s)) {
      return false;
    }
    return true;
  }

  static bool emailUserValidator(String? s) {
    if (s == null || s.length < 3 || hasSpecialChar(s)) {
      return false;
    }
    return true;
  }

  static bool passwordValidator(String? s) {
    if (s == null || s.length < 6) {
      return false;
    }
    return true;
  }

  static bool notEmpty(String? s) {
    return s != null && s.isNotEmpty;
  }
}