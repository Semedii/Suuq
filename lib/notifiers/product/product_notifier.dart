import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/product/product_state.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/services/product_data_service.dart';

part 'product_notifier.g.dart';

@Riverpod()
class ProductNotifier extends _$ProductNotifier {
  final ProductDataService _productDataService = ProductDataService();
  final AuthDataService _authDataService = AuthDataService();

  @override
  ProductState build() {
    return ProductInitialState();
  }

  initPage(String id) async {
    state = ProductLoadingState();
    Product product = await _productDataService.fetchProductsById(id);
    state = ProductLoadedState(product: product);
  }

  Future<void> onFavButtonPressed() async {
    var lastState = state as ProductLoadedState;
    var email = FirebaseAuth.instance.currentUser?.email;
    if (lastState.product.isFav == true) {
      _authDataService.removeProductFromFav(email!, lastState.product.id);
    } else {
      await _authDataService.addProductToFav(email!, lastState.product.id);
    }
    initPage(lastState.product.id);
  }
}
