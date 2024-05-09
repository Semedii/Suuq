import 'package:suuq/utils/enums/payment_option_enum.dart';

abstract class CheckoutState {}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckouLoadedState extends CheckoutState {
  final PaymentOption? paymentOption;
  final String? deliveryAddress;
  final String? sendersName;
  final String? sendersPhone;

  CheckouLoadedState({
     this.paymentOption,
     this.deliveryAddress,
     this.sendersName,
     this.sendersPhone,
  });

  CheckouLoadedState copyWith({
    PaymentOption? paymentOption,
    String? deliveryAddress,
    String? sendersName,
    String? sendersPhone,
  }) {
    return CheckouLoadedState(
      paymentOption: paymentOption ?? this.paymentOption,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      sendersName: sendersName ?? this.sendersName,
      sendersPhone: sendersPhone ?? this.sendersPhone,
    );
  }
}
