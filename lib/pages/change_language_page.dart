import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/utils/enums/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.changeLanguage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              localizations.selectLanguage,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildCurrencySection(),
            const Spacer(),
            AppButton(title: localizations.save, onTap: () {})
          ],
        ),
      ),
    );
  }

  _buildCurrencySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildRadio(
          Language.somali,
          Language.somali,
          "Somali",
          onChanged: (s) {},
        ),
        _buildRadio(
          Language.english,
          Language.english,
          "English",
          onChanged: (s) {},
        ),
      ],
    );
  }

  Widget _buildRadio(
    Language currentValue,
    Language radioValue,
    String title, {
    void Function(Language?)? onChanged,
  }) {
    return Row(
      children: [
        Radio<Language>(
          value: radioValue,
          groupValue: currentValue,
          onChanged: onChanged,
        ),
        Text(title),
      ],
    );
  }
}
