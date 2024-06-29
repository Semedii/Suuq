import 'package:flutter/widgets.dart';
import 'package:suuq/services/storage_service.dart';

class Global {
  static late StorageService storageService;

  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    storageService = await StorageService().init();
  }
}
