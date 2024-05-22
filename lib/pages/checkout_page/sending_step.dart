import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          _buildDesriptionText(context),
          const SizedBox(height: 24),
          _buildSentButton(context, ref),
        ],
      ),
    );
  }

  ElevatedButton _buildSentButton(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () {
        onPaymentSent();
        AutoRouter.of(context).replace(const ConfirmationRoute());
      },
      child: Text(localizations.paymentSent),
    );
  }

  Text _buildDesriptionText(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Text(
      localizations.enterPinExplanation,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18),
    );
  }
}
