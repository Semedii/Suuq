import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/router/app_router.gr.dart';

class SendingStep extends ConsumerWidget {
  const SendingStep({required this.onPaymentSent, super.key});
  final VoidCallback onPaymentSent;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          _buildDesriptionText(),
          const SizedBox(height: 24),
          _buildSentButton(context,ref),
        ],
      ),
    );
  }

  ElevatedButton _buildSentButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
      onPaymentSent();
        AutoRouter.of(context).replace(const ConfirmationRoute());
      },
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
