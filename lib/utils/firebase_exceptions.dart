import 'package:suuq/utils/pop_up_message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptionHandler{
    static  handleFirebaseError(FirebaseException error) {
    switch (error.code) {
      case 'invalid-credential':
        toastInfo("Wrong email or password");
        break;
      case 'invalid-email':
        toastInfo("The email is invalid");
        break;
      default:
        toastInfo("An error occurred: ${error.message}");
    }
  }
}