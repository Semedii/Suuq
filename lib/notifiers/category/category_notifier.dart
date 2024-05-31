import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/category/category_state.dart';
import 'package:suuq/services/product_data_service.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final ProductDataService _productDataService = ProductDataService();
  CategoryNotifier() : super(CategoryInitialState());

  bool _isFetching = false;

  initPage(String category) async {
    state = CategoryLoadingState();
    List<Product?> products =
        await _productDataService.fetchHomePageProducts(category);
    state = CategoryLoadedState(products: products);
  }

  fetchNextBach(String category) async {
    if (_isFetching) return;
    _isFetching = true;
    var lastState = state as CategoryLoadedState;
    state = lastState.copyWith(fetchingNextData: true);
    List<Product?> products = await _productDataService.fetchNextBatchProducts(
        category, lastState.products.last!);
    if (products.isEmpty || products.length < 20) {
      state = lastState.copyWith(noMoreToFetch: true);
    }
    state = CategoryLoadedState(
      products: lastState.products..addAll(products),
      fetchingNextData: false,
    );
    _isFetching = false;
  }
}

final categoryNotifierProvider =
    StateNotifierProvider.autoDispose<CategoryNotifier, CategoryState>(
        (ref) => CategoryNotifier());
