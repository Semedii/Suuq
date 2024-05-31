import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/category/category_state.dart';
import 'package:suuq/services/product_data_service.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final ProductDataService _productDataService = ProductDataService();
  CategoryNotifier() : super(CategoryInitialState());

  initPage(String category) async {
    state = CategoryLoadingState();
    List<Product?> products =
        await _productDataService.fetchHomePageProducts(category);
    state = CategoryLoadedState(products: products);
  }
}

final categoryNotifierProvider =
    StateNotifierProvider.autoDispose<CategoryNotifier, CategoryState>(
        (ref) => CategoryNotifier());
