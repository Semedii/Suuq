import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/notifiers/myProfile/account_notifier.dart';
import 'package:suuq/notifiers/myProfile/account_state.dart';
import 'package:suuq/utils/field_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class PersonalInformationPage extends ConsumerWidget {
  PersonalInformationPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    AccountLoadedState state =
        ref.watch(accountNotifierProvider) as AccountLoadedState;
    return Scaffold(
      appBar: AppBar(
        title:  Text(localizations.personalInformation),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                initialValue: state.userName,
                label: localizations.fullName,
                isDisabled: true,
              ),
              AppTextField(
                initialValue: state.userAddress,
                label: localizations.deliveryAddress,
                onChanged: ref
                    .read(accountNotifierProvider.notifier)
                    .onUserAddressChanged,
                validator: (value) =>
                    FieldValidators.required(value, localizations),
              ),
              AppTextField(
                initialValue: state.userPhoneNumber,
                label: localizations.sendersPhone,
                onChanged: ref
                    .read(accountNotifierProvider.notifier)
                    .onPhoneNumberChanged,
                validator: (value) =>
                    FieldValidators.required(value, localizations),
              ),
              AppTextField(
                initialValue: state.userEmail,
                label: localizations.email,
                isDisabled: true,
              ),
              AppTextField(
                initialValue: state.userJoinedDate.toString(),
                label: localizations.joinedDate,
                isDisabled: true,
              ),
              AppButton(
                  title: localizations.save,
                  isLoading: state.issaveButtonLoading,
                  onTap: () => _onSavePressed(ref, localizations))
            ],
          ),
        ),
      ),
    );
  }

  void _onSavePressed(WidgetRef ref, AppLocalizations localizations) {
    if (_formKey.currentState!.validate()) {
      ref.read(accountNotifierProvider.notifier).onSaveButtonPressed(localizations.successfullyUpdated);
    }
  }
}
