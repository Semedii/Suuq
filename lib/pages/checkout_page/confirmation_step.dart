import 'package:flutter/material.dart';

class ConfirmationStep extends StatelessWidget {
  const ConfirmationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(height: 24),
          _buildTitle(),
          const SizedBox(height: 16),
          _buildDescriptionText(),
          TextButton(onPressed: (){}, child: Text("Call us instead?"))
        ],
      ),
    );
  }

  Icon _buildIcon() {
    return const Icon(
      Icons.check_circle_outline,
      color: Colors.green,
      size: 120,
    );
  }

  Text _buildTitle() {
    return const Text(
      "Thank you for shopping with us!",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _buildDescriptionText() {
    return const Text(
      "Your order has been received. We will confirm the payment and contact you within 5 minutes.",
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}
