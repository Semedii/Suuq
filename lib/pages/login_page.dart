import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/my_app.dart';
import 'package:suuq/notifiers/login/login_notifier.dart';
import 'package:suuq/notifiers/login/login_state.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/enums/language.dart';
import 'package:suuq/utils/pop_up_message.dart';
import 'package:suuq/utils/string_utilities.dart';

import '../components/app_button.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginState = ref.watch(loginInNotifierProvider);
    Locale selectedLanguage =
        ref.read(languageNotifierProvider.notifier).locale;
    return Scaffold(
      body: mapStateToWidget(context, ref, loginState),
    );
  }

  Stack _buildLoginForm(
      BuildContext context, WidgetRef ref, LoginInitialState loginState) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.lightGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: AppStyles.edgeInsetsT16,
                child: Image.asset(
                  "assets/images/lll.png",
                  height: MediaQuery.of(context).size.height * .2,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: size.height * .2,
          child: SingleChildScrollView(
            child: Container(
              padding: AppStyles.edgeInsetsV24,
              height: size.height * .8,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getEmailField(loginState, localizations, ref),
                  _getPasswordField(loginState, localizations, ref),
                  _getForgotPasswordText(localizations),
                  const Spacer(),
                  _getLoginButton(localizations, ref),
                  _getSignupButton(localizations, context)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageButton(WidgetRef ref, Locale selectedLanguage) {
    return Padding(
      padding: AppStyles.edgeInsetsR16,
      child: TextButton(
        onPressed:
            ref.read(languageNotifierProvider.notifier).changeLanguageLogin,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.lightGrey),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child: Text(
          localeToString(selectedLanguage),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  PreferredSize _getAppBarBottom() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Image.asset(
          "assets/images/boy.png",
          width: 150,
          height: 150,
        ));
  }

  AppTextField _getEmailField(
    LoginInitialState loginState,
    AppLocalizations localizations,
    WidgetRef ref,
  ) {
    return AppTextField(
      initialValue: loginState.email,
      label: localizations.email,
      hintText: localizations.enterYourEmailAddress,
      prefixIcon: const Icon(Icons.person),
      onChanged: ref.read(loginInNotifierProvider.notifier).onEmailChanged,
    );
  }

  AppTextField _getPasswordField(
    LoginInitialState loginProvider,
    AppLocalizations localizations,
    WidgetRef ref,
  ) {
    return AppTextField(
      initialValue: loginProvider.password,
      label: localizations.password,
      hintText: localizations.enterYourPassword,
      prefixIcon: const Icon(Icons.lock),
      suffix: _getPasswordFieldSuffix(loginProvider, ref),
      isObscureText: loginProvider.isPasswordHidden,
      onChanged: ref.read(loginInNotifierProvider.notifier).onPasswordChanged,
    );
  }

  IconButton _getPasswordFieldSuffix(
      LoginInitialState loginProvider, WidgetRef ref) {
    return IconButton(
      icon: loginProvider.isPasswordHidden
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
      onPressed:
          ref.read(loginInNotifierProvider.notifier).onIsPasswordHiddenChanged,
    );
  }

  Widget _getForgotPasswordText(AppLocalizations localizations) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: AppStyles.edgeInsetsH20,
        child: Text(
          localizations.forgotYourPassword + StringUtilities.questionMark,
        ),
      ),
    );
  }

  AppButton _getLoginButton(AppLocalizations localizations, WidgetRef ref) {
    return AppButton(
      title: localizations.login,
      onTap: () =>
          ref.read(loginInNotifierProvider.notifier).handleLogin(localizations),
    );
  }

  AppButton _getSignupButton(
    AppLocalizations localizations,
    BuildContext context,
  ) {
    return AppButton(
      title: localizations.signup,
      onTap: () => AutoRouter.of(context).push(SignupRoute()),
    );
  }

  Widget mapStateToWidget(
    BuildContext context,
    WidgetRef ref,
    LoginState loginState,
  ) {
    if (loginState is LoginInitialState) {
      return _buildLoginForm(context, ref, loginState);
    }
    if (loginState is LoginLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (loginState is LoginSuccessState) {
      AutoRouter.of(context).replace(const MainRoute());
    }
    if (loginState is LoginFailureState) {
      toastInfo(loginState.errorMessage);
    }
    return const Center(child: CircularProgressIndicator());
  }
}
