import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_notifier.dart';
import 'package:suuq/notifiers/home/home_state.dart';
import 'package:suuq/pages/homepage/home_page_app_bar.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/enums/category_enum.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: HomePageAppBar(),
        ),
        body: _mapStateToWidget(homeState, ref));
  }

  Widget _mapStateToWidget(HomeState state, WidgetRef ref) {
    if (state is HomeStateInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(homeNotifierProvider.notifier).initPage();
      });
    } else if (state is HomeStateLoaded) {
      return _buildHomePageBody(state);
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Padding _buildHomePageBody(HomeStateLoaded state) {
    return Padding(
      padding: AppStyles.edgeInsets4,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildNiche("Alaabta guriga", state.homeAccessories),
            _buildNiche("Clothes", state.cosmetics),
            _buildNiche("Kabo", state.shoes),
          ],
        ),
      ),
    );
  }

  SizedBox _buildNiche(String nicheName, List<Product?> products,
      ) {
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
                return product!=null? ProductCard(product: product):const Text("not found");
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
