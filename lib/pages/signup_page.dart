import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/notifiers/signup/signup_notifier.dart';
import 'package:suuq/notifiers/signup/signup_state.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/field_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/pop_up_message.dart';

@RoutePage()
class SignupPage extends ConsumerWidget {
  SignupPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    final signupState = ref.watch(signupNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.signup),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: AppStyles.edgeInsetsH20,
              child: Text(
                localizations.enterYourDetailsAndSignUp,
                textAlign: TextAlign.center,
              ),
            )),
      ),
      body: _mapStateToWidget(context, ref, signupState),
    );
  }

  Widget _mapStateToWidget(
    BuildContext context,
    WidgetRef ref,
    SignupState signupState,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    if (signupState is SignupStateInitial) {
      return _buildSignupForm(context, ref, signupState);
    }
    if (signupState is SignupStateLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (signupState is SignupStateSuccess) {
      toastInfo(localizations.verifyEmail);
      AutoRouter.of(context).replace(const LoginRoute());
    }
    if (signupState is SignupStateFailure) {
      toastInfo(signupState.errorMessage);
    }
    return const Center(child: CircularProgressIndicator());
  }

  SingleChildScrollView _buildSignupForm(
    BuildContext context,
    WidgetRef ref,
    SignupStateInitial state,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: AppStyles.edgeInsetsV24,
        child: Column(
          children: [
            _getTextFields(ref, localizations, state),
            _buildSignupButton(localizations, state, ref),
            _buildBackToLoginButton(localizations, context),
          ],
        ),
      ),
    );
  }

  Form _getTextFields(
    WidgetRef ref,
    AppLocalizations localizations,
    SignupStateInitial state,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            initialValue: state.fullName,
            label: localizations.enterYourFullName,
            hintText: localizations.enterYourFullName,
            prefixIcon: const Icon(Icons.person),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onFullNameChanged,
            validator: (value) =>
                FieldValidators.fullName(value, localizations),
          ),
          AppTextField(
            initialValue: state.email,
            label: localizations.email,
            hintText: localizations.enterYourEmailAddress,
            prefixIcon: const Icon(Icons.email),
            onChanged: ref.read(signupNotifierProvider.notifier).onEmailChanged,
            validator: (value) =>
                FieldValidators.required(value, localizations),
          ),
          AppTextField(
            initialValue: state.password,
            label: localizations.password,
            hintText: localizations.enterYourPassword,
            isObscureText: state.isPasswordHidden,
            prefixIcon: const Icon(Icons.lock),
            suffix: IconButton(
              icon: state.isPasswordHidden
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
            initialValue: state.rePassword,
            label: localizations.confirmPassword,
            hintText: localizations.enterYourPasswordAgain,
            prefixIcon: const Icon(Icons.lock),
            isObscureText: state.isRePasswordHidden,
            suffix: IconButton(
              icon: state.isRePasswordHidden
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: ref
                  .read(signupNotifierProvider.notifier)
                  .onisRePasswordHiddenChanged,
            ),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onRePasswordChanged,
            validator: (value1) =>
                FieldValidators.match(value1, state.password, localizations),
          ),
          FormBuilderCheckbox(
              initialValue: state.isAgreed,
              name: "terms",
              onChanged: (value) {
                ref.read(signupNotifierProvider.notifier).onIsAgreedChanged(
                      value,
                    );
              },
              title: _getTermsAndConditionsTitle(localizations),
              validator: (value) =>
                  FieldValidators.checkbox(value, localizations)),
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
              style: const TextStyle(color: AppColors.black)),
          TextSpan(
            text: localizations.termsAndConditions,
            style: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }

  AppButton _buildSignupButton(
      AppLocalizations localizations, SignupStateInitial state, WidgetRef ref) {
    return AppButton(
        title: localizations.signup,
        isLoading: state.isButtonLoading,
        onTap: () => _handleSignUp(ref, localizations));
  }

  AppButton _buildBackToLoginButton(
      AppLocalizations localizations, BuildContext context) {
    return AppButton(
      isTransparent: true,
      title: localizations.backToLogin,
      onTap: () => AutoRouter.of(context).replace(
        const LoginRoute(),
      ),
    );
  }

  void _handleSignUp(WidgetRef ref, AppLocalizations localizations) {
    if (_formKey.currentState!.validate()) {
      ref.read(signupNotifierProvider.notifier).onSignupPressed(localizations);
    }
  }
}
