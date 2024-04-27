import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.label,
    this.prefixIcon,
    this.isObscureText = false,
  });
  final String hintText;
  final String label;
  final Icon? prefixIcon;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(label),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              border: _getBorder(),
              focusedBorder: _getBorder(),
            ),
            obscureText: isObscureText,
          ),
        ],
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
