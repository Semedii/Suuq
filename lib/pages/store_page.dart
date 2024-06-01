import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/utils/app_styles.dart';

import '../utils/enums/category_enum.dart';

@RoutePage()
class StorePage extends StatelessWidget {
   StorePage({super.key});
  final List<Product> products = [
    Product(sellerName: "sellerName", imageUrl: ["imageUrl"], description: "description", price: 2, category: Category.clothes)
  ].expand((element) => [element, element, element, element,element, element, element,element, element, element,element, element, element,]).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PixelBazaar")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 65,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Category.values.length,
              itemBuilder: (context, index) {
              return Padding(
                padding: AppStyles.edgeInsetsH4,
                child: ChoiceChip(label: Text(categoryToString(Category.values[index])), selected: false),
              );
            },)
          ),
         Expanded(
           child: CustomScrollView(
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = products[index];
                  if (product != null) {
                    return ProductCard(product: product);
                  }
                  return const Text("no items found");
                }, childCount: products.length),
              ),
              // if (state.fetchingNextData) ...{
              //    SliverToBoxAdapter(
              //     child: Padding(
              //       padding: AppStyles.edgeInsetsB24,
              //       child: const Center(
              //         child: CircularProgressIndicator(),
              //       ),
              //     ),
              //   ),
              // },
              // if(state.noMoreToFetch)...{
              //    SliverToBoxAdapter(
              //     child: Padding(
              //       padding: AppStyles.edgeInsetsB24,
              //       child:  Center(
              //         child: Text(localizations.end+StringUtilities.exclamationMark),
              //       ),
              //     ),
              //   ),
              //}
            ],
                   ),
         ),
        ],
    ));
  }
}