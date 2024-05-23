enum Language {
  somali,
  english,
}

Language getLanguageFromString(String language) {
  switch (language.toLowerCase()) {
    case 'somali':
      return Language.somali;
    case 'english':
      return Language.english;
    default:
      throw Exception('Unknown category: $Language');
  }
}

String languageToString(Language language) {
  switch (language) {
    case Language.somali:
      return 'somali';
    case Language.english:
      return 'english';
  }
}
