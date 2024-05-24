import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/language/language_notifier.dart';
import 'package:suuq/router/app_router.dart';
import 'package:suuq/utils/app_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final languageNotifier = ref.watch(languageNotifierProvider);
        return MaterialApp.router(
          locale: languageNotifier.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.appThemeData,
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}

final languageNotifierProvider =
    ChangeNotifierProvider((ref) => LanguageNotifier());
