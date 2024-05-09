import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/components/app_checkbox.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/notifiers/checkout/checkout_notifier.dart';
import 'package:suuq/notifiers/checkout/checkout_state.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/enums/payment_option_enum.dart';
import 'package:suuq/utils/field_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CheckOutPage extends ConsumerWidget {
  final double totalAmount;
  CheckOutPage({super.key, required this.totalAmount});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutState = ref.watch(checkoutNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: _mapStateToWidget(context, checkoutState, ref),
    );
  }

  Widget _mapStateToWidget(
    BuildContext context,
    CheckoutState state,
    WidgetRef ref,
  ) {
    if (state is CheckoutInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(checkoutNotifierProvider.notifier).initPage();
      });
    } else if (state is CheckouLoadedState) {
      return _buildCheckoutPage(context, state, ref);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Padding _buildCheckoutPage(
    BuildContext context,
    CheckouLoadedState state,
    WidgetRef ref,
  ) {
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
                const SizedBox(height: 16),
                _buildChoosePaymentSection(state, ref),
                const SizedBox(height: 24),
                _buildAddressField(state.deliveryAddress, ref, localizations),
                const SizedBox(height: 16),
                _buildNameField(state.sendersName, ref, localizations),
                const SizedBox(height: 16),
                _buildPhoneNumberFIeld(state.sendersPhone, ref, localizations),
                const SizedBox(height: 24),
                if (isOutOfWorkingHours) _buildTimeDisclaimer(),
                const SizedBox(height: 24),
                _buildSendButton(),
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

  AppButton _buildSendButton() {
    return AppButton(
      title: "Send Payment",
      onTap: () {
        if (_formKey.currentState!.validate()) {
          print("sent");
        }
      },
    );
  }

  _buildChoosePaymentSection(CheckouLoadedState state, WidgetRef ref) {
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
    required CheckouLoadedState state,
    required Function(bool)? onSelected,
  }) {
    return ChoiceChip(
      label: Text(paymentOptionToString(paymentOption)),
      selected: state.paymentOption == paymentOption,
      onSelected: onSelected,
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
}
