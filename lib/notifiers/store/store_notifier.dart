import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/store/store_state.dart';
import 'package:suuq/services/product_data_service.dart';

class StoreNotifier extends StateNotifier<StoreState> {
  final ProductDataService _productDataService = ProductDataService();
  StoreNotifier() : super(StoreInitialState());
  bool _isFetching = false;
  initPage(String sellerEmail) async {
    state = StoreLoadingState();
    List<Product?>? products =
        await _productDataService.fetchFirstBatchProductsByStore(sellerEmail);
    state = StoreLoadedState(products: products);
  }

  fetchNextBach(String sellerEmail) async {
    if (_isFetching) return;
    _isFetching = true;
    var lastState = state as StoreLoadedState;
    state = lastState.copyWith(nextBatchLoading: true);
    List<Product?>? products =
        await _productDataService.fetchNextBatchProductsByStore(sellerEmail);
    if (products.isEmpty || products.length < 20) {
      state = lastState.copyWith(noMoreToFetch: true);
    }
    state = lastState.copyWith(
        products: lastState.products..addAll(products),
        nextBatchLoading: false);
    _isFetching = false;
  }
}

final storeNotifierProvider =
    StateNotifierProvider.autoDispose<StoreNotifier, StoreState>(
        (ref) => StoreNotifier());
