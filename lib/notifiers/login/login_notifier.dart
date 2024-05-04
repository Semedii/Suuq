import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/notifiers/login/login_state.dart';
import 'package:suuq/services/auth_service.dart';
import 'package:suuq/utils/pop_up_message.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthService authService = AuthService();
  LoginNotifier() : super(LoginInitialState());

  void onEmailChanged(String? email) {
    var lastState = (state as LoginInitialState);
    state = lastState.copyWith(email: email);
  }

  void onPasswordChanged(String? password) {
    var lastState = (state as LoginInitialState);
    state = lastState.copyWith(password: password);
  }

  void onIsPasswordHiddenChanged() {
    var lastState = (state as LoginInitialState);
    state = lastState.copyWith(isPasswordHidden: !lastState.isPasswordHidden);
  }

  void handleLogin() async {
     var lastState = (state as LoginInitialState);
     state = LoginLoadingState();
    try {
      final UserModel? user = await authService.login(lastState.email, lastState.password);
      if(user!=null){
        state = LoginSuccessState(user);
      }else {
        state = LoginFailureState('login failed');
      }
    } catch (e) {
     print("www ${e.toString()}");
    } 
    state = lastState;
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
