import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/language/language_notifier.dart';
import 'package:suuq/router/app_router.dart';
import 'package:suuq/utils/app_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.env});

  final _appRouter = AppRouter();
  final String env;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final languageNotifier = ref.watch(languageNotifierProvider);
        return MaterialApp.router(
          builder: (context, child) {
            if (env == 'prod') return child!;
            return Banner(
              message: env.toUpperCase(),
              location: BannerLocation.topStart,
              child: child,
            );
          },
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
