import 'package:suuq/utils/enums/payment_option_enum.dart';

abstract class CheckoutState {}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutLoadedState extends CheckoutState {
  final int stepIndex;
  final PaymentOption? paymentOption;
  final String? deliveryAddress;
  final String? sendersName;
  final String? sendersPhone;

  CheckoutLoadedState({
    this.stepIndex=0,
     this.paymentOption,
     this.deliveryAddress,
     this.sendersName,
     this.sendersPhone,
  });

  CheckoutLoadedState copyWith({
    int? stepIndex,
    PaymentOption? paymentOption,
    String? deliveryAddress,
    String? sendersName,
    String? sendersPhone,
  }) {
    return CheckoutLoadedState(
      stepIndex: stepIndex??this.stepIndex,
      paymentOption: paymentOption ?? this.paymentOption,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      sendersName: sendersName ?? this.sendersName,
      sendersPhone: sendersPhone ?? this.sendersPhone,
    );
  }
}
