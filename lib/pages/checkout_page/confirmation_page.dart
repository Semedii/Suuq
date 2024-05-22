import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(height: 24),
            _buildTitle(localizations),
            const SizedBox(height: 16),
            _buildDescriptionText(localizations),
            _callUsTextButton(localizations),
            _buildBackToHomePageBtn(localizations, context)
          ],
        ),
      ),
    );
  }

  TextButton _callUsTextButton(AppLocalizations localizations) => TextButton(
        onPressed: () {},
        child: Text(
          localizations.callUsInstead,
          style: const TextStyle(color: AppColors.darkGrey),
        ),
      );

  Icon _buildIcon() {
    return const Icon(
      Icons.check_circle_outline,
      color: Colors.green,
      size: 120,
    );
  }

  Text _buildTitle(AppLocalizations localizations) {
    return Text(
      localizations.thankYouForShopping,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _buildDescriptionText(AppLocalizations localizations) {
    return Text(
      localizations.orderRecievedExplanation,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  AppButton _buildBackToHomePageBtn(
    AppLocalizations localizations,
    BuildContext context,
  ) {
    return AppButton(
        title: localizations.backToHomePage,
        onTap: () {
          AutoRouter.of(context).replace(const MainRoute());
        });
  }
}
