import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/bottomNavBar/bottom_nav_bar_notifier.dart';
import 'package:suuq/pages/homepage/home_page.dart';
import 'package:suuq/pages/my_profile_page.dart';
import 'package:suuq/pages/active_orders.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class MainPage extends ConsumerWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    final indexBottomNavbar = ref.watch(bottomNavBarNotifierProvider);
    final bodies = [
      const HomePage(),
      const ActiveOrders(),
      const MyProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: ref.read(bottomNavBarNotifierProvider.notifier).onTap,
        selectedItemColor: AppColors.black,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopify_sharp),
            label: localizations.activeOrders,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: localizations.myProfile,
          )
        ],
      ),
      body: bodies[indexBottomNavbar],
    );
  }
}
