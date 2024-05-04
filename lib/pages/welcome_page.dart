import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/welcome/index_dot_notifier.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class WelcomePage extends ConsumerWidget {
  WelcomePage({super.key});
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: (value) {
            ref.read(indexDotNotifierProvider.notifier).changeIndex(value);
          },
          children: [
            _buildWelcomePage(
              imageUrl: "assets/images/reading.png",
              title: "Welcome to Suuq",
              subtitle: "Your Ultimate Shopping Destination!",
            ),
            _buildWelcomePage(
              imageUrl: "assets/images/boy.png",
              title: "Explore Thousands of Products",
              subtitle: "Find Everything You Need, from A to Z",
            ),
            _buildWelcomePage(
              imageUrl: "assets/images/man.png",
              title: "Shop Smarter with Suuq",
              subtitle: "Unlock Exclusive Deals and Discounts",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imageUrl),
        const SizedBox(height: 20),
        _getTitle(title),
        const SizedBox(height: 10),
        _getSubtitle(subtitle),
        _getButtonAndIndicator(),
      ],
    );
  }

  Widget _getSubtitle(String subtitle) {
    return Padding(
      padding: AppStyles.edgeInsetsB48,
      child: Text(
        subtitle,
        style: TextStyle(
          fontSize: 18.0,
          color: AppColors.lightGrey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _getTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    );
  }

  Widget _getButtonAndIndicator() {
    return Consumer(
      builder: (context, ref, _) {
        final index = ref.watch(indexDotNotifierProvider);
        return Column(
          children: [
            _getButton(context, index),
            _getIndicator(index),
          ],
        );
      },
    );
  }

  DotsIndicator _getIndicator(int index) {
    return DotsIndicator(
      dotsCount: 3,
      position: index,
      decorator: DotsDecorator(
        activeSize: const Size(28, 9),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  ElevatedButton _getButton(BuildContext context, int index) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(context, index),
      style: _getButtonStyle(),
      child: _getButtonText(index),
    );
  }

  Text _getButtonText(int index) {
    return Text(
      index == 2 ? "Get Started" : "Next",
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkGrey,
      padding:AppStyles.edgeInsetsH32V12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, int index) {
    if (index < 2) {
      _controller.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    else{
      AutoRouter.of(context).push(const LoginRoute());
    }
  }
}
