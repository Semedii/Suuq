import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suuq/components/app_textfield.dart';
import 'package:suuq/utils/app_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: Padding(
            padding: AppStyles.edgeInsetsT40,
            child: Expanded(
              child: Container(
                padding: AppStyles.edgeInsets4,
                color: Colors.grey.withOpacity(0.2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search products...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(
                                  0.2)), // Adjust border color if needed
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(
                                  0.2)), // Adjust focused border color if needed
                        ),
                        // You can add more styling properties like fillColor, filled, etc. as needed
                      ),
                    )),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.mail_outline,)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none_outlined)),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column());
  }
}
