import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/providers/welcome/index_dot_notifier.dart';

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
        _buildButtonAndIndicator(),
      ],
    );
  }

  Widget _getSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Text(
        subtitle,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.grey[600],
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
        color: Colors.black,
      ),
    );
  }

  Widget _buildButtonAndIndicator() {
    return Consumer(
      builder: (context, ref, _) {
        final index = ref.watch(indexDotNotifierProvider);
        return Column(
          children: [
            _getButton(index),
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

  ElevatedButton _getButton(int index) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(index),
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
        color: Colors.white,
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  void _onButtonPressed(int index) {
    if (index < 2) {
      _controller.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
