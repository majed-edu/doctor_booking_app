class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'(?=.*[A-Z])')
    .hasMatch(password);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'(?=.*[a-z])')
    .hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'(?=.*[@$!%*?&])')
    .hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'(?=.*\d)')
    .hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^.{8,}$')
    .hasMatch(password);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phoneNumber);
  }
}