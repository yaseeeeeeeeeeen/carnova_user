class Validations {
  String? emailValidation(value) {
    final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailPattern.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? passwordValidations(String value) {
    if (value.length < 7) {
      return 'Password must have 8 letters';
    } else {
      return null;
    }
  }

  String? confirmpassValidations(String value, String pass) {
    if (value != pass) {
      return 'Password does Not match';
    } else {
      return null;
    }
  }

  String? nameValidation(value) {
    if (value.isEmpty) {
      return 'Enter name';
    } else {
      return null;
    }
  }

  String? phoneNumberValidate(value) {
    final RegExp pattern = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
    if (!pattern.hasMatch(value)) {
      return 'Invalid mobile number';
    }

    return null;
  }
}
