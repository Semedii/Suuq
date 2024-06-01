import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/store/store_state.dart';
import 'package:suuq/services/product_data_service.dart';
import 'package:suuq/utils/category_search_filters.dart';

class StoreNotifier extends StateNotifier<StoreState> {
  final ProductDataService _productDataService = ProductDataService();
  StoreNotifier() : super(StoreInitialState());
  bool _isFetching = false;
  late String sellerEmail;
  initPage(String sellerEmail) async {
    this.sellerEmail = sellerEmail;
    state = StoreLoadingState();
    List<Product?>? products =
        await _productDataService.fetchFirstBatchProductsByStore(sellerEmail);
    state =
        StoreLoadedState(products: products, filters: CategorySearchFilters());
  }

  fetchNextBach(String sellerEmail) async {
    if (_isFetching) return;
    _isFetching = true;
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(nextBatchLoading: true);
    List<Product?>? products = [];
    if (lastState.filters.isAnyFilterActive()) {
      
      final selectedCategory = lastState.filters.getActiveFilters().keys.first;
      products =
          await _productDataService.fetchNextBatchProductsByStoreCategoy(sellerEmail, selectedCategory);
    } else {
      products =
          await _productDataService.fetchNextBatchProductsByStore(sellerEmail);
    }
    
    if (products.isEmpty || products.length < 20) {
      state = lastState.copyWith(noMoreToFetch: true);
      _isFetching = false;
    }
    state = lastState.copyWith(
        products: lastState.products..addAll(products),
        nextBatchLoading: false);
    _isFetching = false;
  }

  onShoesSelected(bool value) async {
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(isFilterUpdating: true);
    CategorySearchFilters categorySearchFilters =
        CategorySearchFilters().copyWith(isShoes: value);
    state = lastState.copyWith(filters: categorySearchFilters);
    await _onFilerApplied(categorySearchFilters);
  }

  onClothesSelected(bool value) async {
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(isFilterUpdating: true);
    CategorySearchFilters categorySearchFilters =
        CategorySearchFilters().copyWith(isClothes: value);
    state = lastState.copyWith(filters: categorySearchFilters);
    await _onFilerApplied(categorySearchFilters);
  }

  onHomeAccessoriesSelected(bool value) async {
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(isFilterUpdating: true);
    CategorySearchFilters categorySearchFilters =
        CategorySearchFilters().copyWith(isHomeAccessories: value);
    state = lastState.copyWith(filters: categorySearchFilters);
    await _onFilerApplied(categorySearchFilters);
  }

  onKitchenAccessoriesSelected(bool value) async {
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(isFilterUpdating: true);
    CategorySearchFilters categorySearchFilters =
        CategorySearchFilters().copyWith(isKitchenAccessories: value);
    state = lastState.copyWith(filters: categorySearchFilters);
    await _onFilerApplied(categorySearchFilters);
  }

  onGymAccessorieselected(bool value) async {
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(isFilterUpdating: true);
    CategorySearchFilters categorySearchFilters =
        CategorySearchFilters().copyWith(isGymAccessories: value);
    state = lastState.copyWith(filters: categorySearchFilters);
    await _onFilerApplied(categorySearchFilters);
  }

  onCosmeticsSelected(bool value) async {
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(isFilterUpdating: true);
    CategorySearchFilters categorySearchFilters =
        CategorySearchFilters().copyWith(isCosmetics: value);
    state = lastState.copyWith(filters: categorySearchFilters);
    await _onFilerApplied(categorySearchFilters);
  }

  onElectronicsSelected(bool value) async {
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(isFilterUpdating: true);
    CategorySearchFilters categorySearchFilters =
        CategorySearchFilters().copyWith(isElectronics: value);
    state = lastState.copyWith(
      filters: categorySearchFilters,
    );
    await _onFilerApplied(categorySearchFilters);
  }

  _onFilerApplied(CategorySearchFilters categorySearchFilters) async {
    final selectedCategory =
        categorySearchFilters.getActiveFilters().keys.first;
    var lastState = state as StoreLoadedState;
    List<Product?> products = await _productDataService
        .fetchFirstBatchProductsByStoreCategoy(sellerEmail, selectedCategory);
    state = StoreLoadedState(products: products, filters: lastState.filters);
  }
}

final storeNotifierProvider =
    StateNotifierProvider.autoDispose<StoreNotifier, StoreState>(
        (ref) => StoreNotifier());
