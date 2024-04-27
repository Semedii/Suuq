class FieldValidators {
  static String? required(value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? match(value1, value2) {
    if (value1 == null || value1.isEmpty) {
      return 'This field is required';
    } else {
      if (value1 != value2) {
        return 'Does not match';
      }
    }
    return null;
  }

  static String? fullName(String? value) {
    if (required(value) != null) {
      return required(value);
    } else if (value!.trim().split(' ').length < 2) {
      return 'Please enter your full name';
    }
    return null;
  }

    static String? password(String? value) {
    if (required(value) != null) {
      return required(value);
    } else if (value!.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }
}
