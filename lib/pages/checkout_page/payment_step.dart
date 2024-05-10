import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/components/app_checkbox.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/notifiers/checkout/checkout_notifier.dart';
import 'package:suuq/notifiers/checkout/checkout_state.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/enums/currency_enum.dart';
import 'package:suuq/utils/enums/payment_option_enum.dart';
import 'package:suuq/utils/field_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentStep extends ConsumerWidget {
  const PaymentStep({required this.totalAmount, super.key});
  final double totalAmount;
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutNotifierProvider) as CheckoutLoadedState;
    AppLocalizations localizations = AppLocalizations.of(context)!;
    bool isOutOfWorkingHours =
        DateTime.now().hour > 21 || DateTime.now().hour < 7;
    return Padding(
      padding: AppStyles.edgeInsetsH16V24,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildPrice(totalAmount),
                _buildChoosePaymentSection(state, ref),
                _buildCurrencySection(state, ref),
                const SizedBox(height: 12),
                _buildAddressField(state.deliveryAddress, ref, localizations),
                _buildNameField(state.sendersName, ref, localizations),
                _buildPhoneNumberFIeld(state.sendersPhone, ref, localizations),
                if (isOutOfWorkingHours) _buildTimeDisclaimer(),
                _buildSendButton(state, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppTextField _buildAddressField(
    String? deliveryAddress,
    WidgetRef ref,
    AppLocalizations localizations,
  ) {
    return AppTextField(
      initialValue: deliveryAddress,
      hintText: "Please enter the delivery address",
      label: "Delivery Address",
      validator: (value) => FieldValidators.required(value, localizations),
      onChanged:
          ref.read(checkoutNotifierProvider.notifier).onDeliveryAddressChanged,
    );
  }

  AppTextField _buildNameField(
    String? sendersName,
    WidgetRef ref,
    AppLocalizations localizations,
  ) {
    return AppTextField(
      initialValue: sendersName,
      hintText: "Please enter the sender's full name",
      label: "Sender's Name",
      validator: (value) => FieldValidators.required(value, localizations),
      onChanged:
          ref.read(checkoutNotifierProvider.notifier).onSendersNameChanged,
    );
  }

  AppTextField _buildPhoneNumberFIeld(
    String? phoneMumber,
    WidgetRef ref,
    AppLocalizations localizations,
  ) {
    return AppTextField(
      initialValue: phoneMumber,
      hintText: "Please enter the Sender's Phone",
      label: "Sender's Phone",
      validator: (value) => FieldValidators.required(value, localizations),
      onChanged:
          ref.read(checkoutNotifierProvider.notifier).onSendersPhoneChanged,
    );
  }

  Column _buildTimeDisclaimer() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            "Please note: Our customer service team is unavailable between 9:00 PM and 7:00 AM. Payments sent during this time will be confirmed the next business day.",
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ),
        AppCheckBox(
          value: false,
          title: const Text("I agree"),
          onChanged: (value) {},
        )
      ],
    );
  }

  _buildChoosePaymentSection(CheckoutLoadedState state, WidgetRef ref) {
    return Column(
      children: [
        _buildPaymentMethodText(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPaymentChip(
              state: state,
              paymentOption: PaymentOption.zaad,
              onSelected: (s) => ref
                  .read(checkoutNotifierProvider.notifier)
                  .onPaymenOptionChanged(PaymentOption.zaad),
            ),
            _buildPaymentChip(
              state: state,
              paymentOption: PaymentOption.edahab,
              onSelected: (_) => ref
                  .read(checkoutNotifierProvider.notifier)
                  .onPaymenOptionChanged(PaymentOption.edahab),
            ),
          ],
        ),
      ],
    );
  }

  Text _buildPaymentMethodText() {
    return const Text(
      "Choose Payment Method",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildPaymentChip({
    required PaymentOption paymentOption,
    required CheckoutLoadedState state,
    required Function(bool)? onSelected,
  }) {
    return ChoiceChip(
      label: Text(paymentOptionToString(paymentOption)),
      selected: state.paymentOption == paymentOption,
      onSelected: onSelected,
      selectedColor: AppColors.green.shade300,
    );
  }

  _buildCurrencySection(CheckoutLoadedState state, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRadio(
          state.currency ?? Currency.shilling,
          Currency.shilling,
          "Shilling",
          onChanged:
              ref.read(checkoutNotifierProvider.notifier).onCurrencyChanged,
        ),
        _buildRadio(
          state.currency ?? Currency.shilling,
          Currency.dollar,
          "Dollar",
          onChanged:
              ref.read(checkoutNotifierProvider.notifier).onCurrencyChanged,
        ),
      ],
    );
  }

  Widget _buildRadio(
    Currency currentValue,
    Currency radioValue,
    String title, {
    void Function(Currency?)? onChanged,
  }) {
    return Row(
      children: [
        Radio<Currency>(
          value: radioValue,
          groupValue: currentValue,
          onChanged: onChanged,
        ),
        Text(title),
      ],
    );
  }

  Text _buildPrice(double price, {double fontSize = 16}) {
    return Text(
      "$price\$",
      style: TextStyle(
        color: AppColors.green,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  AppButton _buildSendButton(
    CheckoutLoadedState state,
    WidgetRef ref,
  ) {
    final bool isDollar = state.currency == Currency.dollar;

    final sendCode = isDollar
        ? "*880*${state.zaadNumber}*$totalAmount"
        : "*220*${state.zaadNumber}*${(totalAmount * state.exchangeRate).toInt()}#";
    return AppButton(
        isLoading: state.isSendButtonLoading,
        title: "Send Payment",
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            await FlutterPhoneDirectCaller.callNumber(sendCode);
            ref.read(checkoutNotifierProvider.notifier).onSendButtonPressed();
          }
        });
  }
}