import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/notifiers/myProfile/account_notifier.dart';
import 'package:suuq/notifiers/myProfile/account_state.dart';
import 'package:suuq/utils/field_validators.dart';

@RoutePage()
class ChangePasswordPage extends ConsumerWidget {
  ChangePasswordPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    AccountLoadedState state =
        ref.watch(accountNotifierProvider) as AccountLoadedState;
    return Scaffold(
      appBar: AppBar(
        title:  Text(localizations.changePassword),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              initialValue: state.newPassword,
              label: localizations.newPassword,
              hintText: localizations.enterYourNewPassword,
              onChanged: ref
                  .read(accountNotifierProvider.notifier)
                  .onNewPasswordChanged,
              validator: (value) =>
                  FieldValidators.password(value, localizations),
            ),
            AppTextField(
              initialValue: state.rePassword,
              label: localizations.confirmPassword,
              hintText: localizations.enterNewPasswordAgain,
              onChanged: ref
                  .read(accountNotifierProvider.notifier)
                  .onRePasswordChanged,
              validator: (value1) => FieldValidators.match(
                  value1, state.newPassword, localizations),
            ),
            AppButton(
                isLoading: state.issaveButtonLoading,
                title: localizations.save,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(accountNotifierProvider.notifier).onSavePassword(localizations);
                  }
                })
          ],
        ),
      ),
    );
  }
}
