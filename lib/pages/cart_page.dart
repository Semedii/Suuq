import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/cart_product.dart';
import 'package:suuq/notifiers/cart/cart_notifier.dart';
import 'package:suuq/notifiers/cart/cart_state.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/string_utilities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    return _mapStateToWidget(context, ref, cartState);
  }

  Widget _mapStateToWidget(
    BuildContext context,
    WidgetRef ref,
    CartState state,
  ) {
    if (state is CartInitialState) {
      ref.watch(cartNotifierProvider.notifier).initPage();
    }
    if (state is CartIdleState) {
      return _buildCartPage(context, state, ref);
    } else {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }

  Scaffold _buildCartPage(
    BuildContext context,
    CartIdleState state,
    WidgetRef ref,
  ) {
    final bool isCartListAvailable = state.cartProductList.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: _buildAppBarTitle(context, isCartListAvailable, state),
      ),
      body: isCartListAvailable
          ? _buildCartList(context, state, ref)
          : _noItemsFoundPage(context),
    );
  }

  RichText _buildAppBarTitle(
    BuildContext context,
    bool isCartListAvailable,
    CartIdleState state,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: localizations.myCart,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
          text: isCartListAvailable
              ? "- ${state.cartProductList.length} ${localizations.product}"
              : StringUtilities.emptyString,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ))
    ]));
  }

  Widget _buildCartList(
    BuildContext context,
    CartIdleState state,
    WidgetRef ref,
  ) {
    return Padding(
      padding: AppStyles.edgeInsetsH16V24,
      child: Column(
        children: [
          Expanded(
            child: Stack(children: [
              SingleChildScrollView(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.read(cartNotifierProvider.notifier).initPage();
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: state.cartProductList
                          .map((e) => _buildCartCard(context, e!, ref))
                          .toList()),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildTotalAndCheckoutButton(context, state))
            ]),
          ),
        ],
      ),
    );
  }

  Column _noItemsFoundPage(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.shopping_cart_rounded,
          size: 60,
        ),
        const SizedBox(
          height: 50,
        ),
        Center(child: Text(localizations.noItemsInYourCart))
      ],
    );
  }

  Widget _buildTotalAndCheckoutButton(
      BuildContext context, CartIdleState state) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              _buildTotalText(context),
              _buildPrice(state.getTotalPrice, fontSize: 20),
            ],
          ),
          _buildButton(context, state)
        ],
      ),
    );
  }

  Text _buildTotalText(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Text(
      localizations.total+StringUtilities.colon,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Card _buildCartCard(
      BuildContext context, CartProduct cartProduct, WidgetRef ref) {
    return Card(
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            _buildImage(cartProduct.imageUrl ?? ''),
            _buildInfoSection(
                context, cartProduct.sellerName, cartProduct.description),
            _buildPriceAndDelete(cartProduct, ref),
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

  Expanded _buildInfoSection(
      BuildContext context, String sellerName, String description) {
    return Expanded(
      child: Padding(
        padding: AppStyles.edgeInsets4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildProductInfo(sellerName, description),
            _buildDeliveryInfo(context)
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryInfo(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Flexible(
      child: Row(
        children: [
          const Icon(Icons.motorcycle_sharp),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(localizations.deliveryWithinOneDay),
            ),
          )
        ],
      ),
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
    CartProduct cartProduct,
    WidgetRef ref,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () => ref
                .read(cartNotifierProvider.notifier)
                .removeFromCart(cartProduct.id),
            icon: const Icon(Icons.delete)),
        _buildPrice(cartProduct.price),
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

  Widget _buildButton(BuildContext context, CartIdleState state) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => AutoRouter.of(context).push(
        CheckOutRoute(
            cartProductList: state.cartProductList,
            totalAmount: state.getTotalPrice),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          localizations.proceedToCheckout,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
