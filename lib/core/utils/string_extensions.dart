
extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }


  bool isWitheSpace() => trim().isEmpty;

  bool isValidDouble() =>double.tryParse(this) != null;

  bool isValidInt() => int.tryParse(this) != null;

  bool isConfirm(String newPassword, String confirmedPassword) {
    if (newPassword.contains(confirmedPassword)) {
      return true;
    }
    return false;
  }

  bool isConfirmOldPWD(
    String password,
    String oldPassword,
  ) {
    if (password.contains(oldPassword)) {
      return true;
    }
    return false;
  }

  bool isVide(String text) {
    if (text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPassword() => false;


  bool isNumberPhone(String phoneNumber) {
    // Define a regular expression pattern for a typical US phone number.
    // You can adjust this pattern to match the phone number format you need.
    final phonePattern = r'^\d{10}$'; // Matches a 10-digit number (e.g., 1234567890)

    // Create a regular expression object.
    final regExp = RegExp(phonePattern);

    // Use the `hasMatch` method to check if the input matches the pattern.
    return regExp.hasMatch(phoneNumber);
  }



}
