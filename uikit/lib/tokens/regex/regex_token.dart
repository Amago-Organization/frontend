final class RegexToken {
  static const String hasUppercase = r'(?=.*[A-Z])';

  static const String hasLowercase = r'(?=.*[a-z])';

  static const String hasNumber = r'(?=.*\d)';

  static const String hasSpecialCharacter = r'(?=.*[^a-zA-Z0-9])';

  static const String length = r'.{6,10}';

  static const String password =
      '^'
      '$hasUppercase'
      '$hasLowercase'
      '$hasNumber'
      '$hasSpecialCharacter'
      '$length'
      r'$';

  static const String email =
      r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
}