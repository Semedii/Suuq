import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/providers/signup/signup_state.dart';
import 'package:suuq/services/auth_service.dart';
import 'package:suuq/utils/pop_up_message.dart';

part 'signup_notifier.g.dart';

@riverpod
class SignupNotifier extends _$SignupNotifier {
  @override
  SignupState build() {
    return SignupState();
  }

  void onFullNameChanged(String? fullName) {
    state = state.copyWith(fullName: fullName);
  }

  void onEmailChanged(String? email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String? password) {
    state = state.copyWith(password: password);
  }

  void onRePasswordChanged(String? rePassword) {
    state = state.copyWith(rePassword: rePassword);
  }

  void onIsAgreedChanged(bool? isAgreed) {
    state = state.copyWith(isAgreed: isAgreed);
  }

  void onisPasswordHiddenChanged() {
    state = state.copyWith(isPasswordHidden: !state.isPasswordHidden);
  }

  void onisRePasswordHiddenChanged() {
    state = state.copyWith(isRePasswordHidden: !state.isRePasswordHidden);
  }

  void onSignupPressed() async {
    state = state.copyWith(isButtonLoading: true);
    try {
      final authService = AuthService();
      await authService.signup(state.email, state.password);
    } catch (e) {
      if (e is FirebaseException) {
        handleFirebaseError(e);
      } else {
        toastInfo("unknown error");
      }
    } finally {
      state = state.copyWith(isButtonLoading: false);
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
