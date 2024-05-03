import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/global.dart';
import 'package:suuq/router/app_router.dart';
import 'package:suuq/utils/app_theme.dart';

void main() async {
  Global.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.appThemeData,
      routerConfig: _appRouter.config(),
    );
  }
}
