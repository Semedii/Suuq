import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/providers/signup/signup_notifier.dart';
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
        bottom:  PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Text(localizations.enterYourDetailsAndSignUp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              _getTextFields(ref, localizations),
              _getTermsAndConditionsSection(ref),
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
            validator: FieldValidators.fullName,
          ),
          AppTextField(
            initialValue: signUpProvider.email,
            label: localizations.email,
            hintText: localizations.enterYourEmailAddress,
            prefixIcon: const Icon(Icons.email),
            onChanged: ref.read(signupNotifierProvider.notifier).onEmailChanged,
            validator: FieldValidators.required,
          ),
          AppTextField(
            initialValue: signUpProvider.password,
            label: localizations.password,
            hintText: localizations.enterYourPassword,
            prefixIcon: const Icon(Icons.lock),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onPasswordChanged,
            validator: FieldValidators.password,
          ),
          AppTextField(
            initialValue: signUpProvider.rePassword,
            label: localizations.confirmPassword,
            hintText: localizations.enterYourPasswordAgain,
            prefixIcon: const Icon(Icons.lock),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onRePasswordChanged,
            validator: (value1) =>
                FieldValidators.match(value1, signUpProvider.password),
          ),
        ],
      ),
    );
  }

  Row _getTermsAndConditionsSection(WidgetRef ref) {
    return Row(
      children: [
        Checkbox(
          value: ref.read(signupNotifierProvider).isAgreed,
          onChanged:
              ref.read(signupNotifierProvider.notifier).onIsAgreedChanged,
          activeColor: Colors.grey,
          checkColor: Colors.black,
        ),
        const Flexible(
          child: Text(
            "By creating an account you have to agree with our terms & conditions",
          ),
        )
      ],
    );
  }

  void _handleSignUp(WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      ref.read(signupNotifierProvider.notifier).onSignupPressed();
    }
  }
}
