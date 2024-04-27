import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/app_button.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: Image.asset(
              "assets/images/boy.png",
              width: 150,
              height: 150,
            )),
        title: const Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: localizations.email,
            hintText: localizations.enterYourEmailAddress,
            prefixIcon: Icon(Icons.person),
          ),
          AppTextField(
            label: localizations.password,
            hintText: localizations.enterYourPassword,
            prefixIcon: const Icon(Icons.lock),
            isObscureText: true,
          ),
          _getForgotPasswordText(localizations),
          AppButton(title: localizations.login, onTap: () {}),
          AppButton(
            title: localizations.signup,
            onTap: () => AutoRouter.of(context).push(SignupRoute()),
          )
        ],
      ),
    );
  }

  Widget _getForgotPasswordText(AppLocalizations localizations) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Text(localizations.forgotYourPassword),
      ),
    );
  }
}
