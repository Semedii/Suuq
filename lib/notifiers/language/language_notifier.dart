import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/utils/enums/language.dart';
import 'package:suuq/utils/pop_up_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageNotifier extends ChangeNotifier {
  final AuthDataService _authDataService = AuthDataService();
  Locale _locale = const Locale('es');
  Locale get locale => _locale;

  void setLocale(Locale newLocale, AppLocalizations localizations) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (_locale != newLocale) {
      _locale = newLocale;
      await _authDataService.updateLanguage(
          email: email!, language: localeToLangugae(locale));
      notifyListeners();
      toastInfo(localizations.successfullyUpdated);
    }
  }

  void changeLanguageLogin() {
    if (locale == const Locale('es')) {
      _locale = const Locale('en');
    } else {
      if (locale == const Locale('en')) _locale = const Locale('es');
    }
    notifyListeners();
  }

  void fetchLocaleFromDatabase(user) async {
    if (user == null) return;
    final email = FirebaseAuth.instance.currentUser?.email;
    user = await _authDataService.fetchCurrentUser(email!);
    _locale = languageToLocale(user.language);
    notifyListeners();
  }
}
