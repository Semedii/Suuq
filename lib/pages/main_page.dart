import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/bottomNavBar/bottom_nav_bar_notifier.dart';
import 'package:suuq/pages/homepage/home_page.dart';
import 'package:suuq/pages/my_profile_page.dart';
import 'package:suuq/pages/orders_page.dart';
import 'package:suuq/utils/app_colors.dart';

@RoutePage()
class MainPage extends ConsumerWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(bottomNavBarNotifierProvider);
    final bodies = [
      const HomePage(),
       OrdersPage(),
      const MyProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: ref.read(bottomNavBarNotifierProvider.notifier).onTap,
        selectedItemColor: AppColors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopify_sharp), label: "My Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile")
        ],
      ),
      body: bodies[indexBottomNavbar],
    );
  }
}
