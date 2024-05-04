import 'package:flutter/material.dart';
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
          color: Colors.grey.withOpacity(0.2),
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
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Search products...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
    );
  }
}
