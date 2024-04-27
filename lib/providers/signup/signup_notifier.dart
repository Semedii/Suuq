import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/providers/signup/signup_state.dart';
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

  void onSignupPressed() async {
    state = state.copyWith(isButtonLoading: true);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      print("credentials $credential");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        toastInfo("This email is already in use");
      } else if (e.code == 'invalid-email') {
        toastInfo("The email is invalid");
      }
    } catch (e) {
      print(e);
    }
    state = state.copyWith(isButtonLoading: false);
  }
}
