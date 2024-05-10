import 'package:flutter/material.dart';

class PaymentInstructionScreen extends StatelessWidget {
  const PaymentInstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          _buildDesriptionText(),
          const SizedBox(height: 24),
          _buildSentButton(),
        ],
      ),
    );
  }

  ElevatedButton _buildSentButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("Payment Sent"),
    );
  }

  Text _buildDesriptionText() {
    return const Text(
      "Please enter your pin and click the button below once it's sent.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    );
  }
}
