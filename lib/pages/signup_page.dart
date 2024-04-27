import 'package:flutter/material.dart';
import 'package:suuq/components/app_buton.dart';
import 'package:suuq/components/app_textfield.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            AppButton(title: "Back to Login", onTap: () {}),
          ],
        ),
      ),
    );
  }

  Column _getTextFields() {
    return const Column(
      children: [
        AppTextField(label: "Username", hintText: "Enter your username"),
        AppTextField(label: "Email", hintText: "Enter your email address"),
        AppTextField(label: "Password", hintText: "Enter your password"),
        AppTextField(
          label: "Confirm Password",
          hintText: "Enter your password again",
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
