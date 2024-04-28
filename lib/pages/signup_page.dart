import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/components/app_checkbox.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/notifiers/signup/signup_notifier.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/field_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class SignupPage extends ConsumerWidget {
  SignupPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    final signUpProvider = ref.watch(signupNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.signup),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                localizations.enterYourDetailsAndSignUp,
                textAlign: TextAlign.center,
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              _getTextFields(ref, localizations),
              AppButton(
                  title: localizations.signup,
                  isLoading: signUpProvider.isButtonLoading,
                  onTap: () => _handleSignUp(ref)),
              AppButton(
                title: localizations.backToLogin,
                onTap: () => AutoRouter.of(context).replace(
                  const LoginRoute(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form _getTextFields(WidgetRef ref, AppLocalizations localizations) {
    final signUpProvider = ref.watch(signupNotifierProvider);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            initialValue: signUpProvider.fullName,
            label: localizations.enterYourFullName,
            hintText: localizations.enterYourFullName,
            prefixIcon: const Icon(Icons.person),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onFullNameChanged,
            validator: (value) =>
                FieldValidators.fullName(value, localizations),
          ),
          AppTextField(
            initialValue: signUpProvider.email,
            label: localizations.email,
            hintText: localizations.enterYourEmailAddress,
            prefixIcon: const Icon(Icons.email),
            onChanged: ref.read(signupNotifierProvider.notifier).onEmailChanged,
            validator: (value) =>
                FieldValidators.required(value, localizations),
          ),
          AppTextField(
            initialValue: signUpProvider.password,
            label: localizations.password,
            hintText: localizations.enterYourPassword,
            isObscureText: signUpProvider.isPasswordHidden,
            prefixIcon: const Icon(Icons.lock),
            suffix: IconButton(
              icon: signUpProvider.isPasswordHidden
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: ref
                  .read(signupNotifierProvider.notifier)
                  .onisPasswordHiddenChanged,
            ),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onPasswordChanged,
            validator: (value) =>
                FieldValidators.password(value, localizations),
          ),
          AppTextField(
            initialValue: signUpProvider.rePassword,
            label: localizations.confirmPassword,
            hintText: localizations.enterYourPasswordAgain,
            prefixIcon: const Icon(Icons.lock),
            isObscureText: signUpProvider.isRePasswordHidden,
            suffix: IconButton(
              icon: signUpProvider.isRePasswordHidden
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: ref
                  .read(signupNotifierProvider.notifier)
                  .onisRePasswordHiddenChanged,
            ),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onRePasswordChanged,
            validator: (value1) => FieldValidators.match(
                value1, signUpProvider.password, localizations),
          ),
          AppCheckBox(
            title: _getTermsAndConditionsTitle(localizations),
            value: ref.watch(signupNotifierProvider).isAgreed,
            onChanged: (s) {
              ref.read(signupNotifierProvider.notifier).onIsAgreedChanged(s);
            },
            validator: (value) =>
                FieldValidators.checkbox(value, localizations),
          ),
        ],
      ),
    );
  }

  Widget _getTermsAndConditionsTitle(AppLocalizations localizations) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: localizations.iAccept,
              style: const TextStyle(color: Colors.black)),
          TextSpan(
            text: localizations.termsAndConditions,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }

  void _handleSignUp(WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      ref.read(signupNotifierProvider.notifier).onSignupPressed();
    }
  }
}
