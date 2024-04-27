import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 32, right: 32),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: _getDecoration(),
        child: _getTitleText(),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF64B5F6), Color(0xFF2196F3)],
      ),
    );
  }

  Center _getTitleText() {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
