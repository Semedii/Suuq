import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/store/store_state.dart';
import 'package:suuq/services/product_data_service.dart';

class StoreNotifier extends StateNotifier<StoreState> {
  final ProductDataService _productDataService = ProductDataService();
  StoreNotifier() : super(StoreInitialState());

  initPage(String sellerEmail)async{
    state = StoreLoadingState();
    List<Product?>? products = await _productDataService.fetchAllProductsByStore(sellerEmail);
    state = StoreLoadedState(products: products);

  }

}

final storeNotifierProvider =
    StateNotifierProvider.autoDispose<StoreNotifier, StoreState>((ref) => StoreNotifier());
