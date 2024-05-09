import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/cart/cart_notifier.dart';
import 'package:suuq/notifiers/cart/cart_state.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/string_utilities.dart';

@RoutePage()
class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    return _mapStateToWidget(ref, cartState);
  }

  Widget _mapStateToWidget(WidgetRef ref, CartState state) {
    if (state is CartInitialState) {
      ref.watch(cartNotifierProvider.notifier).initPage();
    }
    if (state is CartIdleState) {
      return _buildCartPage(state, ref);
    } else {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }

  Scaffold _buildCartPage(CartIdleState state, WidgetRef ref) {
    final bool isCartListAvailable = state.cartList.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: _buildAppBarTitle(isCartListAvailable, state),
      ),
      body: isCartListAvailable
          ? _buildCartList(state, ref)
          : _noItemsFoundPage(),
    );
  }

  RichText _buildAppBarTitle(bool isCartListAvailable, CartIdleState state) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: "My Cart",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600)),
      TextSpan(
          text: isCartListAvailable
              ? "- ${state.cartList.length} products"
              : StringUtilities.emptyString,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ))
    ]));
  }

  Column _buildCartList(CartIdleState state, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: state.cartList
                      .map((e) => _buildCartCard(e!, ref))
                      .toList()),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Expanded(
                  child: _buildTotalAndCheckoutButton(state),
                ))
          ]),
        ),
      ],
    );
  }

  Column _noItemsFoundPage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_cart_rounded,
          size: 60,
        ),
        SizedBox(
          height: 50,
        ),
        Center(child: Text("No items in your Cart"))
      ],
    );
  }

  Row _buildTotalAndCheckoutButton(CartIdleState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            _buildTotalText(),
            _buildPrice(state.getTotalPrice, fontSize: 20),
          ],
        ),
        _buildButton("Proceed to Checkout")
      ],
    );
  }

  Text _buildTotalText() {
    return const Text(
      "Total:",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Card _buildCartCard(Product product, WidgetRef ref) {
    return Card(
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            _buildImage(product.imageUrl.first ?? ''),
            _buildInfoSection(product.sellerName, product.description),
            _buildPriceAndDelete(product, ref),
          ],
        ),
      ),
    );
  }

  SizedBox _buildImage(String imageUrl) {
    return SizedBox(
      width: 100,
      height: 130,
      child: Image.memory(
        base64Decode(imageUrl),
        fit: BoxFit.cover,
      ),
    );
  }

  Expanded _buildInfoSection(String sellerName, String description) {
    return Expanded(
      child: Padding(
        padding: AppStyles.edgeInsets4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildProductInfo(sellerName, description),
            _buildDeliveryInfo()
          ],
        ),
      ),
    );
  }

  Row _buildDeliveryInfo() {
    return const Row(
      children: [
        Icon(Icons.motorcycle_sharp),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Delivery within one day"),
        )
      ],
    );
  }

  RichText _buildProductInfo(String sellerName, String description) {
    return RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: sellerName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
          TextSpan(
              text: "   $description",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ))
        ]));
  }

  Column _buildPriceAndDelete(
    Product product,
    WidgetRef ref,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () =>
                ref.read(cartNotifierProvider.notifier).removeFromCart(product),
            icon: const Icon(Icons.delete)),
        _buildPrice(product.price),
      ],
    );
  }

  Text _buildPrice(double price, {double fontSize = 16}) {
    return Text(
      "$price\$",
      style: TextStyle(
        color: AppColors.green,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildButton(String title,
      {bool isTransparent = false, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isTransparent ? null : Colors.green,
          border: isTransparent ? Border.all() : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isTransparent ? Colors.black : Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
