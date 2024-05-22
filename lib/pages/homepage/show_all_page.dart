import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ShowAllPage extends StatelessWidget {
  const ShowAllPage({required this.categoryName, required this.products, super.key});
  final List<Product?> products;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text("${localizations.all} $categoryName"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7, // Adjust this ratio based on your card's design
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            if (product != null) return ProductCard(product: product);
            return const SizedBox.shrink(); // Return an empty widget if product is null
          },
        ),
      ),
    );
  }
}
