import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/notifiers/signup/signup_state.dart';
import 'package:suuq/services/auth_service.dart';
import 'package:suuq/utils/pop_up_message.dart';

part 'signup_notifier.g.dart';

@riverpod
class SignupNotifier extends _$SignupNotifier {
  @override
  SignupState build() {
    return SignupStateInitial();
  }

  void onFullNameChanged(String? fullName) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(fullName: fullName);
  }

  void onEmailChanged(String? email) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(email: email);
  }

  void onPasswordChanged(String? password) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(password: password);
  }

  void onRePasswordChanged(String? rePassword) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(rePassword: rePassword);
  }

  void onIsAgreedChanged(bool? isAgreed) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(isAgreed: isAgreed);
  }

  void onisPasswordHiddenChanged() {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(isPasswordHidden: !lastState.isPasswordHidden);
  }

  void onisRePasswordHiddenChanged() {
    var lastState = state as SignupStateInitial;
    state =
        lastState.copyWith(isRePasswordHidden: !lastState.isRePasswordHidden);
  }

  void onSignupPressed() async {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(isButtonLoading: true);
    try {
      final authService = AuthService();
      state = SignupStateLoading();
      await authService.signup(lastState.email, lastState.password);
      state = SignupStateSuccess();
    } catch (e) {
      if (e is FirebaseException) {
        handleFirebaseError(e);
      } else {
        toastInfo("unknown error");
      }
    } finally {
      state = SignupStateInitial();
    }
  }

  void handleFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'email-already-in-use':
        toastInfo("This email is already in use");
        break;
      case 'invalid-email':
        toastInfo("The email is invalid");
        break;
      default:
        toastInfo("An error occurred: ${e.message}");
    }
  }
}
