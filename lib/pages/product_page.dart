import 'package:flutter/material.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/utils/app_colors.dart';

@immutable
class ProductPage extends StatelessWidget {
  const ProductPage(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => throw UnimplementedError(),
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
                      _buildImage(context),
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

  Container _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 4),
      color: AppColors.lightestGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPrice(),
          _buildButton("Buy Now"),
          _buildButton("To Cart", isTransparent: true),
        ],
      ),
    );
  }

  SizedBox _buildImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Image.asset(
        product.imageUrl!,
        fit: BoxFit.cover,
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
              text: product.sellerName,
              style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            TextSpan(
              text: ' - ${product.description}',
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
      '${product.price.toStringAsFixed(2)}\$',
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

  Widget _buildButton(String title, {bool isTransparent = false}) {
    return Container(
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
    );
  }
}
