import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_button.dart';
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
                _buildChoosePaymentSection(state, ref, localizations),
                _buildCurrencySection(state, ref),
                const SizedBox(height: 12),
                _buildAddressField(state.deliveryAddress, ref, localizations),
                _buildNameField(state.sendersName, ref, localizations),
                _buildPhoneNumberFIeld(state.sendersPhone, ref, localizations),
                if (isOutOfWorkingHours) _buildTimeDisclaimer(localizations),
                _buildSendButton(localizations, state, ref),
                _chatWithUsWhatsapp(localizations),
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
      hintText: localizations.enterDeliveryAddress,
      label: localizations.deliveryAddress,
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
      hintText: localizations.enterYourFullName,
      label: localizations.sendersName,
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
      hintText: localizations.enterSendersPhone,
      label: localizations.sendersPhone,
      validator: (value) => FieldValidators.required(value, localizations),
      onChanged:
          ref.read(checkoutNotifierProvider.notifier).onSendersPhoneChanged,
    );
  }

  Column _buildTimeDisclaimer(AppLocalizations localizations) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            localizations.outOfOfficeHoursNotice,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  _buildChoosePaymentSection(
    CheckoutLoadedState state,
    WidgetRef ref,
    AppLocalizations localizations,
  ) {
    return Column(
      children: [
        _buildPaymentMethodText(localizations),
        const SizedBox(height: 8),
        FormBuilderChoiceChip(
          alignment: WrapAlignment.spaceAround,
          decoration: const InputDecoration(border: InputBorder.none),
          backgroundColor: Colors.transparent,
          selectedColor: AppColors.green.shade300,
          onChanged: (paymentOption) =>
              ref.read(checkoutNotifierProvider.notifier).onPaymenOptionChanged(
                    getPaymentOptionFromString(paymentOption!),
                  ),
          validator: (value) => FieldValidators.required(value, localizations),
          name: "paymentMethod",
          options: const [
            FormBuilderChipOption(value: "Zaad"),
            FormBuilderChipOption(value: "Edahab"),
          ],
        ),
      ],
    );
  }

  Text _buildPaymentMethodText(AppLocalizations localizations) {
    return Text(
      localizations.choosePaymentMethod,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
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
    AppLocalizations localizations,
    CheckoutLoadedState state,
    WidgetRef ref,
  ) {
    return AppButton(
        isLoading: state.isSendButtonLoading,
        title: localizations.sendPayment,
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            await FlutterPhoneDirectCaller.callNumber(
                _getZaadEdahabCodes(state));
            ref.read(checkoutNotifierProvider.notifier).onSendButtonPressed();
          }
        });
  }

  Widget _chatWithUsWhatsapp(AppLocalizations localizations) {
    return Padding(
      padding: AppStyles.edgeInsets8,
      child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.green),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
          child: Padding(
            padding: AppStyles.edgeInsets4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.chat_rounded,
                  color: Colors.white,
                ),
                Text(localizations.contactuswhatsapp),
              ],
            ),
          )),
    );
  }

  String _getZaadEdahabCodes(CheckoutLoadedState state) {
    final bool isDollar = state.currency == Currency.dollar;
    int? cents = _getCents();
    final dollarCodeWithoutCents =
        "*880*${state.zaadNumber}*${totalAmount.toInt()}#";
    final dollarCodeWithCents =
        "*880*${state.zaadNumber}*${totalAmount.toInt()}*$cents#";
    final dollarCode =
        cents == null ? dollarCodeWithoutCents : dollarCodeWithCents;
    final shillingCode =
        "*220*${state.zaadNumber}*${(totalAmount * state.exchangeRate).toInt()}#";

    return isDollar ? dollarCode : shillingCode;
  }

  int? _getCents() {
    final String decimal = (totalAmount - totalAmount.floor()).toString();
    final int cents = int.parse(decimal.split('.').last);
    if (cents > 0) {
      return cents;
    }
    return null;
  }
}
