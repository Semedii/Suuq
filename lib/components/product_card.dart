import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';

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
      onTap: () => AutoRouter.of(context).push(ProductRoute(product: product)),
      child: Card(
        child: SizedBox(
          width: 150,
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isImageAvailable
                  ? Expanded(
                      child: Image.network(
                        product.imageUrl.first!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      "assets/images/noImageAvailable.jpeg",
                      height: 200,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
              Padding(
                padding: AppStyles.edgeInsets4,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: product.sellerName.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " - ${product.description}",
                        style: const TextStyle(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: AppStyles.edgeInsets4,
                child: Text(
                  "${product.price.toStringAsFixed(2)}\$",
                  style: const TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
