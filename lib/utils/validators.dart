class Validators {
  static String? isRequired(value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? doesMatch(value1, value2) {
    if (value1 == null || value1.isEmpty) {
      return 'This field is required';
    } else {
      if (value1 != value2) {
        return 'Does not match';
      }
    }
    return null;
  }
}
