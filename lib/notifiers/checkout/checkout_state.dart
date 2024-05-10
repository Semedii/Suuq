import 'package:suuq/utils/enums/currency_enum.dart';
import 'package:suuq/utils/enums/payment_option_enum.dart';

abstract class CheckoutState {}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutLoadedState extends CheckoutState {
  final int stepIndex;
  final PaymentOption? paymentOption;
  final Currency? currency;
  final int edahabNumber;
  final int zaadNumber;
  final int exchangeRate;
  final String? deliveryAddress;
  final String? sendersName;
  final String? sendersPhone;
  final bool isSendButtonLoading;

  CheckoutLoadedState({
    this.currency,
    required this.edahabNumber,
    required this.zaadNumber,
    required this.exchangeRate,
    this.stepIndex = 0,
    this.paymentOption,
    this.deliveryAddress,
    this.sendersName,
    this.sendersPhone,
    this.isSendButtonLoading = false,
  });

  CheckoutLoadedState copyWith({
    int? stepIndex,
    PaymentOption? paymentOption,
    Currency? currency,
    String? deliveryAddress,
    String? sendersName,
    String? sendersPhone,
    bool? isSendButtonLoading,
  }) {
    return CheckoutLoadedState(
      stepIndex: stepIndex ?? this.stepIndex,
      paymentOption: paymentOption ?? this.paymentOption,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      sendersName: sendersName ?? this.sendersName,
      sendersPhone: sendersPhone ?? this.sendersPhone,
      isSendButtonLoading: isSendButtonLoading ?? this.isSendButtonLoading,
      currency: currency??this.currency,
      zaadNumber: zaadNumber,
      edahabNumber: edahabNumber,
      exchangeRate: exchangeRate,
    );
  }
}
