import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/bottomNavBar/bottom_nav_bar_notifier.dart';
import 'package:suuq/pages/homepage/home_page.dart';

class MainPage extends ConsumerWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(bottomNavBarNotifierProvider);
    final bodies = [
      const HomePage(),
      const Center(
        child: Text('Hello From Favorite Screen'),
      ),
      const Center(
        child: Text('Hello From Settings Screen'),
      ),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: ref.read(bottomNavBarNotifierProvider.notifier).onTap,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile")
        ],
      ),
      body: bodies[indexBottomNavbar],
    );
  }
}
