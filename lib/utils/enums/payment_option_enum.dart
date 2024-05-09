enum PaymentOption {
  zaad,
  edahab,
}

PaymentOption getPaymentOptionFromString(String paymentOption) {
  switch (paymentOption.toLowerCase()) {
    case 'zaad':
      return PaymentOption.zaad;
    case 'edahab':
      return PaymentOption.edahab;
    default:
      throw Exception('Unknown category: $paymentOption');
  }
}

String paymentOptionToString(PaymentOption paymentOption) {
  switch (paymentOption) {
    case PaymentOption.zaad:
      return 'zaad';
    case PaymentOption.edahab:
      return 'edahab';
  }
}
