import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:suuq/components/app_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderFailurePage extends StatelessWidget {
  const OrderFailurePage({this.contactNumber, super.key});
  final String? contactNumber;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: AppStyles.edgeInsetsH16V24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(),
              const SizedBox(height: 24),
              _buildTitle(localizations),
              const SizedBox(height: 16),
              _buildDescriptionText(localizations),
              _chatWithUsWhatsapp(localizations, context),
              _callUstButton(localizations),
            ],
          ),
        ),
      ),
    );
  }

  Icon _buildIcon() {
    return const Icon(
      Icons.error,
      color: Colors.red,
      size: 120,
    );
  }

  Text _buildTitle(AppLocalizations localizations) {
    return Text(
      localizations.errorHasHappened,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _buildDescriptionText(AppLocalizations localizations) {
    return Text(
      localizations.orderErrorExplanation,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  AppButton _chatWithUsWhatsapp(
    AppLocalizations localizations,
    BuildContext context,
  ) {
    return AppButton(
        title: localizations.whatsapp,
        prefixWidget: const Icon(
          Icons.chat_rounded,
          color: Colors.white,
        ),
        onTap: () async {
          await launchUrl(Uri.parse(
              "https://api.whatsapp.com/send?phone=${_getWhatsappNumber()}&text=ASC"));
        });
  }

  TextButton _callUstButton(AppLocalizations localizations) => TextButton(
      onPressed: () {},
      child: AppButton(
          title: localizations.callUsInstead,
          prefixWidget: const Icon(
            Icons.call,
            color: Colors.white,
          ),
          onTap: () async {
            FlutterPhoneDirectCaller.callNumber(contactNumber ?? "");
          }));

  String? _getWhatsappNumber() {
    String? whatsappNumber;
    if (contactNumber != null) {
      whatsappNumber = '+252${contactNumber!.substring(1)}';
    }
    return whatsappNumber;
  }
}
