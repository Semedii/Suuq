import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:suuq/firebase_options.dart';
import 'package:suuq/services/storage_service.dart';

class Global {
  static late StorageService storageService;

  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
  }
}
