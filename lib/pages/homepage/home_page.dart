import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/categories_list.dart';
import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_notifier.dart';
import 'package:suuq/notifiers/home/home_state.dart';
import 'package:suuq/pages/homepage/home_page_app_bar.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    return _mapStateToWidget(context, homeState, ref);
  }

  Widget _mapStateToWidget(
      BuildContext context, HomeState state, WidgetRef ref) {
    if (state is HomeStateInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(homeNotifierProvider.notifier).initPage();
      });
    } else if (state is HomeStateLoaded) {
      return _buildHomePageBody(context, state, ref);
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildHomePageBody(
    BuildContext context,
    HomeStateLoaded state,
    WidgetRef ref,
  ) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: HomePageAppBar(
            numberItemsInCart: state.numberItemsInCart,
          ),
        ),
        body: Padding(
          padding: AppStyles.edgeInsets4,
          child: RefreshIndicator(
            onRefresh: () async {
              ref.read(homeNotifierProvider.notifier).initPage();
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shop By Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child: Text("See All"))
                  ],
                ),
                CategoriesList(),
                _buildProductsList(state.shoes),
              ],
            ),
          ),
        ));
  }

  Widget _buildProductsList(List<Product?> products) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          childAspectRatio: .55,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return product != null
              ? ProductCard(product: product)
              : const Text("not found");
        },
      ),
    );
  }
}
