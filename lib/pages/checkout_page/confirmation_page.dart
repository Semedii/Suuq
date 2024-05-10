import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';

@RoutePage()
class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(height: 24),
            _buildTitle(),
            const SizedBox(height: 16),
            _buildDescriptionText(),
            _callUsTextButton(),
            AppButton(title: "Back to homepage", onTap: (){AutoRouter.of(context).replace(const MainRoute());})
          ],
        ),
      ),
    );
  }

  TextButton _callUsTextButton() => TextButton(
        onPressed: () {},
        child: const Text(
          "Call us instead?",
          style: TextStyle(color: AppColors.darkGrey),
        ),
      );

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
