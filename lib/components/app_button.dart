import 'package:flutter/material.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.prefixWidget,
    this.isLoading = false,
    this.isSmall = false,
  });
  final String title;
  final Widget? prefixWidget;
  final bool isLoading;
  final bool isSmall;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: isSmall? phoneWidth*.4: phoneWidth*.8,
        margin: AppStyles.edgeInsetsT20L32R32,
        padding: AppStyles.edgeInsetsV10H20,
        decoration: _getDecoration(),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.white,
              ))
            : _getTitleText(),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: AppColors.darkGrey,
    );
  }

  Row _getTitleText() {
    return Row(
      children: [
        prefixWidget!=null? prefixWidget!: const SizedBox.shrink(),
        Expanded(
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
