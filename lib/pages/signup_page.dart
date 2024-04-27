import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_buton.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/providers/signup/signup_notifier.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/field_validators.dart';

@RoutePage()
class SignupPage extends ConsumerWidget {
  SignupPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpProvider = ref.watch(signupNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Text("Enter your details below & free signup")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              _getTextFields(ref),
              _getTermsAndConditionsSection(ref),
              AppButton(
                  title: "Sign up",
                  isLoading: signUpProvider.isButtonLoading,
                  onTap: () => _handleSignUp(ref)),
              AppButton(
                title: "Back to Login",
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

  Form _getTextFields(WidgetRef ref) {
    final signUpProvider = ref.watch(signupNotifierProvider);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            initialValue: signUpProvider.fullName,
            label: "Full Name",
            hintText: "Enter your username",
            prefixIcon: const Icon(Icons.person),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onFullNameChanged,
            validator: FieldValidators.fullName,
          ),
          AppTextField(
            initialValue: signUpProvider.email,
            label: "Email",
            hintText: "Enter your email address",
            prefixIcon: const Icon(Icons.email),
            onChanged: ref.read(signupNotifierProvider.notifier).onEmailChanged,
            validator: FieldValidators.required,
          ),
          AppTextField(
            initialValue: signUpProvider.password,
            label: "Password",
            hintText: "Enter your password",
            prefixIcon: const Icon(Icons.lock),
            onChanged:
                ref.read(signupNotifierProvider.notifier).onPasswordChanged,
            validator: FieldValidators.password,
          ),
          AppTextField(
            initialValue: signUpProvider.rePassword,
            label: "Confirm Password",
            hintText: "Enter your password again",
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
