import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/login/login_state.dart';
import 'package:suuq/services/auth_service.dart';
import 'package:suuq/utils/pop_up_message.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  void onEmailChanged(String? email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String? password) {
    state = state.copyWith(password: password);
  }

  void onIsPasswordHiddenChanged() {
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  void handleLogin() async {
    try {
      final authService = AuthService();
     final credential =  await authService.login(state.email, state.password);

     var user = credential.user;
     if(user!=null){
      String? displayName = user.displayName;
      String? email = user.email;
      String? id = user.uid;
      String? photoUrl = user.photoURL;

      
     }
    } catch (e) {
      if (e is FirebaseException) {
        handleFirebaseError(e);
      } else {
        toastInfo("unknown error");
      }
    } finally {}
  }

  void handleFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'invalid-credential':
        toastInfo("Wrong email or password");
        break;
      case 'invalid-email':
        toastInfo("The email is invalid");
        break;
      default:
        toastInfo("An error occurred: ${e.message}");
    }
  }
}

final loginInNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);
