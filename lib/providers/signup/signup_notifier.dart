import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/providers/signup/signup_state.dart';

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

  void onSignupPressed(){
    print("fullname: ${state.fullName}, email: ${state.email}");
  }
}
