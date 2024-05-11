import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_notifier.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/cart_product_helper.dart';

@RoutePage()
class ProductPage extends StatefulWidget {
  const ProductPage(this.product, {super.key});

  final Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    bool isImageAvailable = widget.product.imageUrl.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => AutoRouter.of(context).push(const CartRoute()),
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () => throw UnimplementedError(),
            icon: const Icon(Icons.share_sharp),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCarousel(context, isImageAvailable),
                      _buildDescription(),
                      _buildReviews(),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0, left: 0, right: 0, child: _buildBottomBar()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 4),
        color: AppColors.lightestGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPrice(),
            _buildButton(
              "Buy Now",
              onTap: () => AutoRouter.of(context).push(CheckOutRoute(
                  totalAmount: widget.product.price,
                  cartList: [CartProductHelper.getCartFromProduct(widget.product)])),
            ),
            _buildButton("To Cart", isTransparent: true, onTap: () {
              ref.read(homeNotifierProvider.notifier).addToCart(widget.product);
            }),
          ],
        ),
      );
    });
  }

  bool isss = false;
  int _current = 0;
  Widget buildCarousel(BuildContext context, bool isImageAvailable) {
    return Column(
      children: [
        CarouselSlider(
          options: _buildCarouselOptions(context),
          items: widget.product.imageUrl.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: isImageAvailable
                      ? Image.memory(
                          base64Decode(url ?? ''),
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/noImageAvailable.jpeg",
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                );
              },
            );
          }).toList(),
        ),
        if (widget.product.imageUrl.length > 1) _buildDotIndicator()
      ],
    );
  }

  CarouselOptions _buildCarouselOptions(BuildContext context) {
    return CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.6,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index, reason) {
        setState(() {
          _current = index;
        });
      },
    );
  }

  DotsIndicator _buildDotIndicator() {
    return DotsIndicator(
      dotsCount: widget.product.imageUrl.length,
      position: _current,
      decorator: DotsDecorator(
        shape: const Border(),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        size: const Size.square(10),
        activeSize: const Size(20, 10),
      ),
    );
  }

  Padding _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.product.sellerName,
              style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            TextSpan(
              text: ' - ${widget.product.description}',
              style: const TextStyle(color: AppColors.black, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildStarRating(3),
          const SizedBox(width: 8),
          _buildReviewsText(),
        ],
      ),
    );
  }

  Text _buildReviewsText() {
    return const Text(
      '${3.9}/5 (${190} reviews)',
      style: TextStyle(
        color: AppColors.black,
        fontSize: 16,
      ),
    );
  }

  Text _buildPrice() {
    return Text(
      '${widget.product.price.toStringAsFixed(2)}\$',
      style: const TextStyle(
        color: AppColors.green,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: const Color.fromARGB(255, 151, 121, 3),
        ),
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
