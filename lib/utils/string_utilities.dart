class StringUtilities {
  static const String questionMark = "?";
  static const String emptyString = "";
  static const String colon = ":";
}

extension StringExension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
