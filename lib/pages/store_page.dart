import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/store/store_notifier.dart';
import 'package:suuq/notifiers/store/store_state.dart';
import 'package:suuq/utils/app_styles.dart';

import '../utils/enums/category_enum.dart';

@RoutePage()
class StorePage extends ConsumerWidget {
  const StorePage(
      {required this.sellerEmail, required this.storename, super.key});
  final String storename;
  final String sellerEmail;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeState = ref.watch(storeNotifierProvider);
    return Scaffold(
        appBar: AppBar(title: Text(storename)),
        body: _mapStateToWidget(storeState, ref));
  }

  Widget _mapStateToWidget(StoreState state, WidgetRef ref) {
    if (state is StoreInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(storeNotifierProvider.notifier).initPage(sellerEmail);
      });
    } else if (state is StoreLoadedState) {
      return _buildPageBody(state.products);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Column _buildPageBody(List<Product?> products) {
    return Column(
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
                  child: ChoiceChip(
                      label: Text(categoryToString(Category.values[index])),
                      selected: false),
                );
              },
            )),
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
    );
  }
}
