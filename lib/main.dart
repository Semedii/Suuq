import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/router/app_router.dart';
import 'package:suuq/utils/app_theme.dart';

void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      theme: AppTheme.appThemeData,
      routerConfig: _appRouter.config(),
    );
  }
}

