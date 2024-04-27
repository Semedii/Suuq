import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_buton.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/providers/signup/signup_notifier.dart';
import 'package:suuq/router/app_router.gr.dart';

@RoutePage()
class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            _getTextFields(ref),
            _getTermsAndConditionsSection(ref),
            AppButton(title: "Sign up", onTap: ref.read(signupNotifierProvider.notifier).onSignupPressed),
            AppButton(
              title: "Back to Login",
              onTap: () => AutoRouter.of(context).replace(
                const LoginRoute(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _getTextFields(WidgetRef ref) {
    return Column(
      children: [
        AppTextField(
          label: "Full Name",
          hintText: "Enter your username",
          prefixIcon: const Icon(Icons.person),
          onChanged:
              ref.read(signupNotifierProvider.notifier).onFullNameChanged,
        ),
        AppTextField(
          label: "Email",
          hintText: "Enter your email address",
          prefixIcon: const Icon(Icons.email),
          onChanged: ref.read(signupNotifierProvider.notifier).onEmailChanged,
        ),
        AppTextField(
          label: "Password",
          hintText: "Enter your password",
          prefixIcon: const Icon(Icons.lock),
          onChanged:
              ref.read(signupNotifierProvider.notifier).onPasswordChanged,
        ),
        AppTextField(
          label: "Confirm Password",
          hintText: "Enter your password again",
          prefixIcon: const Icon(Icons.lock),
          onChanged:
              ref.read(signupNotifierProvider.notifier).onRePasswordChanged,
        ),
      ],
    );
  }

  Row _getTermsAndConditionsSection(WidgetRef ref) {
    return Row(
      children: [
        Checkbox(
          value: true,
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
}
