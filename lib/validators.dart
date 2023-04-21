class Validators {
  static bool isStringNotEmpty(String? value, [bool isRequired = true]) {
    if (isRequired) {
      if ((value == null) || (value.isEmpty)) {
        return false;
      }
    }
    return true;
  }

  static bool isEmail(String? value) {
    if (isStringNotEmpty(value)) {
      if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value!)) {
        return true;
      }
    }
    return false;
  }

  static bool isPassword(String? value, [String? first]) {
    if (isStringNotEmpty(value)) {
      if (value!.length >= 8) {
        if (first != null) {
          return value == first;
        }
        return true;
      }
    }
    return false;
  }
}
