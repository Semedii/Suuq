import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/string_utilities.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    final bool isImageAvailable = product.imageUrl.isNotEmpty;
    return GestureDetector(
      onTap: () =>
          AutoRouter.of(context).push(ProductRoute(productId: product.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 270,
            child: isImageAvailable
                ? _getImageFromNetwork()
                : _getImageFromAsset(),
          ),
          _getSellerName(),
          _getProductDescription(),
          _buildProductPrice()
        ],
      ),
    );
  }

  Image _getImageFromAsset() {
    return Image.asset(
      "assets/images/noImageAvailable.jpeg",
      height: 200,
      width: 150,
      fit: BoxFit.cover,
    );
  }

  ClipRRect _getImageFromNetwork() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        product.imageUrl.first!,
        fit: BoxFit.cover,
        width: 200,
        loadingBuilder: _imageNetworkLoadingBuilder,
      ),
    );
  }

  Widget _imageNetworkLoadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) {
      return child;
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }
  }

  Text _getSellerName() {
    return Text(
      product.sellerName.toUpperCase(),
      style: TextStyle(
        color: AppColors.lightGrey,
      ),
    );
  }

  Text _getProductDescription() {
    return Text(
      product.description.capitalize(),
      style: const TextStyle(
        color: AppColors.black,
      ),
    );
  }

  Padding _buildProductPrice() {
    return Padding(
      padding: AppStyles.edgeInsets4,
      child: Text(
        "${product.price.toStringAsFixed(2)}\$",
        style: const TextStyle(
          color: AppColors.green,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
