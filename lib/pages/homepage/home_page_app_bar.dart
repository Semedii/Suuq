import 'package:flutter/material.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.edgeInsetsT40,
      child: Expanded(
        child: Container(
          padding: AppStyles.edgeInsets4,
          color: AppColors.lightestGrey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _buildSearchField(),
              ),
              _buildMessagesButton(),
              _buildNotificationsButton(),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _buildNotificationsButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.notifications_none_outlined,
      ),
    );
  }

  IconButton _buildMessagesButton() => IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.mail_outline,
      ));

  TextField _buildSearchField() {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightestGrey,
        hintText: "Search coming soon...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: AppColors.lightestGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.lightestGrey),
        ),
      ),
    );
  }
}
