import 'package:flutter/material.dart';
import 'package:suuq/utils/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });
  final String title;
  final bool isLoading;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 350,
        margin: AppStyles.edgeInsetsT20L32R32,
        padding: AppStyles.edgeInsetsV10H20,
        decoration: _getDecoration(),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : _getTitleText(),
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
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
