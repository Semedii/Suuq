import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/notifiers/category/category_notifier.dart';
import 'package:suuq/notifiers/category/category_state.dart';

@RoutePage()
class CategoryPage extends ConsumerWidget {
  const CategoryPage({required this.categoryName, super.key});
  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryNotifierProvider);
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text("${localizations.all} $categoryName"),
        ),
        body: _mapStateToWidget(context, state, ref));
  }

  Widget _mapStateToWidget(
      BuildContext context, CategoryState state, WidgetRef ref) {
    if (state is CategoryInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryNotifierProvider.notifier).initPage(categoryName);
      });
    } else if (state is CategoryLoadedState) {
      return _buildPageBody(context, state.products);
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Padding _buildPageBody(BuildContext context, List<Product?> products) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
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
            )
          ],
        ));
  }
}
