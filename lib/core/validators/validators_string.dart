mixin ValidatorMixin {
  String getEmailErrors(String email) {
    if (!email.contains('@')) {
      return "Invalid Email format missing @";
    } else if (email.length < 5 || email.isEmpty) {
      return "This is not an email";
    } else {
      return "";
    }
  }

  String getPasswordErrors(String password) {
    if (password.length < 6) {
      return "Password length is too short";
    } else {
      return "";
    }
  }

  String getInputFieldErrors(String name) {
    if (name.length < 4) {
      return "length is too short";
    }
    if (name.isEmpty) {
      return "This field cannot be empty";
    } else {
      return "";
    }
  }

  String getShortFieldErrors(String val) {
    if (val.length < 2) {
      return "length is too short";
    }
    if (val.isEmpty) {
      return "This field cannot be empty";
    } else {
      return "";
    }
  }
}
