

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/global.dart';
import 'package:suuq/my_app.dart';

void main() async {
  await Global.init();
  runApp(ProviderScope(child: MyApp()));
}
