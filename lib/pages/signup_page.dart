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
            _getTextFields(),
            _getTermsAndConditionsSection(),
            AppButton(title: "Sign up", onTap: () {}),
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

  Column _getTextFields() {
    return const Column(
      children: [
        AppTextField(
          label: "Full Name",
          hintText: "Enter your username",
          prefixIcon: Icon(Icons.person),
        ),
        AppTextField(
          label: "Email",
          hintText: "Enter your email address",
          prefixIcon: Icon(Icons.email),
        ),
        AppTextField(
          label: "Password",
          hintText: "Enter your password",
          prefixIcon: Icon(Icons.lock),
        ),
        AppTextField(
          label: "Confirm Password",
          hintText: "Enter your password again",
          prefixIcon: Icon(Icons.lock),
        ),
      ],
    );
  }

  Row _getTermsAndConditionsSection() {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (s) {},
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
