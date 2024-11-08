import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/notifiers/login/login_state.dart';
import 'package:suuq/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  void handleLogin(AppLocalizations localizations) async {
     var lastState = (state as LoginInitialState);
     state = LoginLoadingState();
    try {
      final UserModel? user = await authService.login(lastState.email, lastState.password, localizations);
      if(user!=null){
        state = LoginSuccessState(user);
      }else {
        state = lastState;
      }
    } catch (e) {
      throw Exception(e);
    } 
  }


void handleLogout() async {
  state = LoginLoadingState();
  authService.logout();
  state = LoginInitialState();
}
}

final loginInNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);
