import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isObscureText = false,
  });
  final String hintText;
  final Icon? prefixIcon;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          border: _getBorder(),
          focusedBorder: _getBorder(),
        ),
        obscureText: isObscureText,
      ),
    );
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
