import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.label,
    this.prefixIcon,
    this.suffix,
    this.isObscureText = false,
    this.onChanged,
    this.validator,
  });
  final String? initialValue;
  final String hintText;
  final String label;
  final Icon? prefixIcon;
  final Widget? suffix;
  final bool isObscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

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
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffix,
              border: _getBorder(),
              focusedBorder: _getBorder(),
            ),
            obscureText: isObscureText,
            onChanged: onChanged,
            validator: validator,
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
