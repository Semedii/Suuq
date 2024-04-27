import 'package:flutter/material.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/pages/signup_page.dart';

import '../components/app_buton.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          const AppTextField(
            label: "Email",
            hintText: "Enter your email address",
            prefixIcon: Icon(Icons.person),
          ),
          const AppTextField(
            label: "Password",
            hintText: "Enter your Password",
            prefixIcon: Icon(Icons.lock),
            isObscureText: true,
          ),
          _getForgotPasswordText(),
          AppButton(title: "Login", onTap: () {}),
          AppButton(
              title: "Sign up",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              }),
        ],
      ),
    );
  }

  Widget _getForgotPasswordText() {
    return GestureDetector(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Text("Forgot your password?"),
      ),
    );
  }
}
