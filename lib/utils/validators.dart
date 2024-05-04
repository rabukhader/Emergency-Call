class Validator {
  static bool emailFieldValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool phoneNumerValidation(String phoneNumber) {
    return RegExp(r'^0[0-9]{9}$').hasMatch(phoneNumber);
  }
}
