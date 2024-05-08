import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/global.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/notifiers/myProfile/my_profile_state.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/services/auth_service.dart';
import 'package:suuq/utils/pop_up_message.dart';

part 'my_profile_notifier.g.dart';

@Riverpod()
class MyProfileNotifier extends _$MyProfileNotifier {
  final AuthDataService _authDataService = AuthDataService();
  final AuthService _authService = AuthService();
  @override
  MyProfileState build() {
    return MyProfileInitialState();
  }

  initPage() async {
    final String? userEmail =
        await Global.storageService.getString('userEmail');
    final UserModel user = await _authDataService.fetchCurrentUser(userEmail!);
    state = MyProfileLoadedState(
        userName: user.name!,
        userEmail: user.email!,
        userPhoneNumber: user.phoneNumber!,
        userJoinedDate: user.joinedDate!,
        userAddress: user.address,
        userAvatar: user.avatar);
  }

  onUserAddressChanged(String address) {
    state = (state as MyProfileLoadedState).copyWith(userAddress: address);
  }

  onPhoneNumberChanged(String phoneMumber) {
    state =
        (state as MyProfileLoadedState).copyWith(userPhoneNumber: phoneMumber);
  }

  onNewPasswordChanged(String newPassword) {
    state = (state as MyProfileLoadedState).copyWith(newPassword: newPassword);
  }

  onRePasswordChanged(String rePassword) {
    state = (state as MyProfileLoadedState).copyWith(rePassword: rePassword);
  }

  onSavePassword() async {
    var currentState = state as MyProfileLoadedState;
    state = currentState.copyWith(issaveButtonLoading: true);
    await _authService.changePassword(currentState.newPassword!);
    state = currentState.copyWith(issaveButtonLoading: false);
    toastInfo("Successfully updated");
  }

  onSaveButtonPressed() async {
    var currentState = state as MyProfileLoadedState;
    state = currentState.copyWith(issaveButtonLoading: true);
    await _authDataService.updateUserInfo(
        email: currentState.userEmail,
        phoneNumber: currentState.userPhoneNumber,
        address: currentState.userAddress!,
        name: currentState.userName);
    state = currentState.copyWith(issaveButtonLoading: false);
    toastInfo("Successfully updated");
  }
}
