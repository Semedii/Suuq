import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/pages/homepage/home_page_app_bar.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/enums/category_enum.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: HomePageAppBar(),
        ),
        body: Padding(
          padding: AppStyles.edgeInsets4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildNiche("Alaabta guriga", homeAccessories, expand: false),
                _buildNiche("Clothes", tShirts),
                _buildNiche("Kabo", shoes),
              ],
            ),
          ),
        ));
  }

  SizedBox _buildNiche(String nicheName, List<Product> products,
      {bool expand = true}) {
    if (expand) {
      products = products
          .expand((element) => [element, element, element, element])
          .toList();
    }
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nicheName,
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Show All",
                style: TextStyle(
                    color: AppColors.green, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Product> tShirts = [
  Product(
      sellerName: "Shaal Online",
      description: "Garan/Garamad oversize ah",
      price: 12,
      imageUrl: "assets/images/tshirt.jpg",
      category: Category.clothes),
];

List<Product> shoes = [
  Product(
      sellerName: "Semedy",
      description: "kabo shark triko oo madaw",
      price: 12,
      imageUrl: "assets/images/shoe.jpg",
      category: Category.shoes),
];

List<Product> homeAccessories = [
  Product(
      sellerName: "Shaal Online",
      description: "Container ama box-ka cuntada lagu kaydiyo",
      price: 5,
      imageUrl: "assets/images/container.jpg",
      category: Category.homeAccessories),
  Product(
      sellerName: "Suuq Online",
      description: "Maqli aan ku dhegeyn",
      price: 15,
      imageUrl: "assets/images/pan.jpg",
      category: Category.homeAccessories),
  Product(
      sellerName: "WaxWalba Online",
      description: "Hanger-ka dharka la sudho",
      price: 6,
      imageUrl: "assets/images/hanger.jpg",
      category: Category.homeAccessories),
];
