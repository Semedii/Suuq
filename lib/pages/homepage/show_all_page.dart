import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/notifiers/category/category_notifier.dart';
import 'package:suuq/notifiers/category/category_state.dart';

@RoutePage()
class CategoryPage extends ConsumerWidget {
  const CategoryPage({required this.categoryName,super.key});
  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryNotifierProvider);
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text("${localizations.all} $categoryName"),
      ),
      body:
      
      _mapStateToWidget(state, ref)
    );
  }
  Widget _mapStateToWidget(CategoryState state, WidgetRef ref){
    if(state is CategoryInitialState){
       WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryNotifierProvider.notifier).initPage(categoryName);
       });
    } else if(state is CategoryLoadedState){
     return _buildPageBody(state.products);
    }
    return const Center(child: CircularProgressIndicator(),);
  }

  Padding _buildPageBody(List<Product?> products) {
    return Padding(
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
    );
  }
}
