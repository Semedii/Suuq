import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>AutoRouter.of(context).push(ProductRoute(product: product)),
      child: Card(
        child: SizedBox(
          width: 150,
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(
                base64Decode(product.imageUrl.first??""),
                height: 200,
                width: 150,
                fit: BoxFit.cover,
              ),
              RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: product.sellerName,
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
              Text(
                "${product.price.toStringAsFixed(2)}\$",
                style: const TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
