import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/merchant_data.dart';
import 'package:suuq/models/order.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/notifiers/checkout/checkout_state.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/services/merchant_data_service.dart';
import 'package:suuq/services/order_data_service.dart';
import 'package:suuq/utils/enums/currency_enum.dart';
import 'package:suuq/utils/enums/payment_option_enum.dart';

part 'checkout_notifier.g.dart';

@Riverpod()
class CheckoutNotifier extends _$CheckoutNotifier {
  final AuthDataService _authDataService = AuthDataService();
  final MerchantDataService _merchantDataService = MerchantDataService();
  final OrderDataService _orderDataService = OrderDataService();

  late UserModel user;
  @override
  CheckoutState build() {
    return CheckoutInitialState();
  }

  initPage() async {
    state = CheckoutLoadingState();
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    user = await _authDataService.fetchCurrentUser(userEmail!);
    final MerchantData merchantData =
        await _merchantDataService.fetchMerchantData();
    state = CheckoutLoadedState(
      zaadNumber: merchantData.zaadNumber,
      edahabNumber: merchantData.edahabNumber,
      exchangeRate: merchantData.exchangeRate,
      deliveryAddress: user.address,
      sendersName: user.name,
      sendersPhone: user.phoneNumber,
      currency: Currency.shilling
    );
  }

  onPaymenOptionChanged(PaymentOption option) {
    state = (state as CheckoutLoadedState).copyWith(paymentOption: option);
  }

  onDeliveryAddressChanged(String deliveryAddress) {
    state = (state as CheckoutLoadedState)
        .copyWith(deliveryAddress: deliveryAddress);
  }

  onSendersNameChanged(String sendersName) {
    state = (state as CheckoutLoadedState).copyWith(sendersName: sendersName);
  }

  onSendersPhoneChanged(String sendersPhone) {
    state = (state as CheckoutLoadedState).copyWith(sendersPhone: sendersPhone);
  }

  onCurrencyChanged(Currency? currency) {
    state = (state as CheckoutLoadedState).copyWith(currency: currency);
  }

  onSendButtonPressed() async {
    state = (state as CheckoutLoadedState).copyWith(isSendButtonLoading: true);
    await Future.delayed(const Duration(seconds: 1));
    state = (state as CheckoutLoadedState)
        .copyWith(stepIndex: 1, isSendButtonLoading: false);
  }

  onStepTapped(int index) {
     if (index < 1) {
    state = (state as CheckoutLoadedState).copyWith(stepIndex: index);
     }
  }

  onPaymentSent(List<Product?> products, double totalPrice) {
    var lastState = state as CheckoutLoadedState;
    final newOrder = OrderModel(
      sendersPhone: lastState.sendersPhone!,
      customer: user,
      address: lastState.deliveryAddress!,
      orderedDate: DateTime.now(),
      products: products,
      totalPrice: totalPrice,
      currency: lastState.currency!,
      paymentOption: lastState.paymentOption!,
    );
    _orderDataService.addNewOrder(newOrder);
  }
}
