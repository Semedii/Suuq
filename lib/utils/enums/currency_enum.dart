enum Currency {
  shilling,
  dollar,
}

Currency getCurrencyFromString(String currency) {
  switch (currency.toLowerCase()) {
    case 'dollar':
      return Currency.dollar;
    case 'shilling':
      return Currency.shilling;
    default:
      throw Exception('Unknown category: $currency');
  }
}

String currencyToString(Currency currency) {
  switch (currency) {
    case Currency.dollar:
      return 'dollar';
    case Currency.shilling:
      return 'shilling';
  }
}
