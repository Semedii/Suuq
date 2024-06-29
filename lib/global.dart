import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:suuq/services/storage_service.dart';

class Global {
  static late StorageService storageService;

 static Future<void> handleBackgroundMessage(RemoteMessage message)async{}

  static init() async {
    storageService = await StorageService().init();
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
