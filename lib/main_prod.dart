import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/global.dart';
import 'package:suuq/my_app.dart';

import 'firebase_options_prod.dart';

void main() async {
  await Global.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp(env:  "prod")));
}
