import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/components/app_checkbox.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class CheckOutPage extends StatelessWidget {
  final double totalAmount;
  const CheckOutPage({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    bool isOutOfWorkingHours =
        DateTime.now().hour > 21 || DateTime.now().hour < 7;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: AppStyles.edgeInsetsH16V24,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildChoosePaymentSection(),
                const SizedBox(height: 24),
                _buildAddressField(),
                const SizedBox(height: 16),
                _buildNameField(),
                const SizedBox(height: 16),
                _buildPhoneNumberFIeld(),
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

  AppTextField _buildAddressField() {
    return const AppTextField(
      hintText: "Delivery Address",
      label: "Delivery Address",
    );
  }

  AppTextField _buildNameField() {
    return const AppTextField(
      hintText: "Sender's Name",
      label: "Sender's Name",
    );
  }

  AppTextField _buildPhoneNumberFIeld() {
    return const AppTextField(
      hintText: "Sender's Phone",
      label: "Sender's Phone",
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
      onTap: () {},
    );
  }

  _buildChoosePaymentSection() {
    return Column(
      children: [
        _buildPaymentMethodText(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPaymentChip(
              label: "Zaad",
              isSelected: true,
              onPressed: () {},
            ),
            _buildPaymentChip(
              label: "Edahab",
              isSelected: false,
              onPressed: () {},
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
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (isSelected) {
        if (!isSelected) {
          onPressed();
        }
      },
    );
  }
}
