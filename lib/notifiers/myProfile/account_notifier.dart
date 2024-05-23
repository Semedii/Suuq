import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/notifiers/myProfile/account_state.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/services/auth_service.dart';
import 'package:suuq/utils/enums/language.dart';
import 'package:suuq/utils/pop_up_message.dart';

part 'account_notifier.g.dart';

@Riverpod()
class AccountNotifier extends _$AccountNotifier {
  final AuthDataService _authDataService = AuthDataService();
  final AuthService _authService = AuthService();
  @override
  AccountState build() {
    return AccountInitialState();
  }

  initPage() async {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    final UserModel user = await _authDataService.fetchCurrentUser(userEmail!);
    state = AccountLoadedState(
        userName: user.name!,
        userEmail: user.email!,
        language: user.language,
        userPhoneNumber: user.phoneNumber,
        userJoinedDate: user.joinedDate!,
        userAddress: user.address,
        userAvatar: user.avatar);
  }

  onUserAddressChanged(String address) {
    state = (state as AccountLoadedState).copyWith(userAddress: address);
  }

  onPhoneNumberChanged(String phoneMumber) {
    state =
        (state as AccountLoadedState).copyWith(userPhoneNumber: phoneMumber);
  }

  onNewPasswordChanged(String newPassword) {
    state = (state as AccountLoadedState).copyWith(newPassword: newPassword);
  }

  onRePasswordChanged(String rePassword) {
    state = (state as AccountLoadedState).copyWith(rePassword: rePassword);
  }

  onChangeLanguage(Language? language) {
    state = (state as AccountLoadedState).copyWith(language: language);
  }

  onSavePassword() async {
    var currentState = state as AccountLoadedState;
    state = currentState.copyWith(issaveButtonLoading: true);
    await _authService.changePassword(currentState.newPassword!);
    state = currentState.copyWith(issaveButtonLoading: false);
    toastInfo("Successfully updated");
  }

  onSaveButtonPressed() async {
    var currentState = state as AccountLoadedState;
    state = currentState.copyWith(issaveButtonLoading: true);
    await _authDataService.updateUserInfo(
        email: currentState.userEmail,
        phoneNumber: currentState.userPhoneNumber!,
        address: currentState.userAddress!,
        name: currentState.userName);
    state = currentState.copyWith(issaveButtonLoading: false);
    toastInfo("Successfully updated");
  }

  onSaveLanguagePressed() async {
    var currentState = state as AccountLoadedState;
    state = currentState.copyWith(issaveButtonLoading: true);
    await _authDataService.updateLanguage(
        email: currentState.userEmail, language: currentState.language);
    state = currentState.copyWith(issaveButtonLoading: false);
    toastInfo("Successfully updated");
  }
}
