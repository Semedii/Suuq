import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/notifiers/checkout/checkout_state.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/utils/enums/payment_option_enum.dart';

part 'checkout_notifier.g.dart';

@Riverpod()
class CheckoutNotifier extends _$CheckoutNotifier {
  final AuthDataService _authDataService = AuthDataService();
  @override
  CheckoutState build() {
    return CheckoutInitialState();
  }

  initPage() async {
    state = CheckoutLoadingState();
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    final UserModel user = await _authDataService.fetchCurrentUser(userEmail!);
    state = CheckouLoadedState(
      deliveryAddress: user.address,
      sendersName: user.name,
      sendersPhone: user.phoneNumber,
    );
  }

  onPaymenOptionChanged(PaymentOption option) {
    state = (state as CheckouLoadedState).copyWith(paymentOption: option);
  }

  onDeliveryAddressChanged(String deliveryAddress) {
    state = (state as CheckouLoadedState)
        .copyWith(deliveryAddress: deliveryAddress);
  }

  onSendersNameChanged(String sendersName) {
    state = (state as CheckouLoadedState).copyWith(sendersName: sendersName);
  }

  onSendersPhoneChanged(String sendersPhone) {
    state = (state as CheckouLoadedState).copyWith(sendersPhone: sendersPhone);
  }
}
