import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/cart.dart';
import 'package:suuq/models/cart_product.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/cart/cart_state.dart';
import 'package:suuq/services/cart_data_service.dart';
import 'package:suuq/services/product_data_service.dart';

part 'cart_notifier.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  final CartDataService _cartDataService = CartDataService();
  final ProductDataService _productDataService = ProductDataService();
  late String? userEmail;
  @override
  CartState build() {
    return CartInitialState();
  }

  void initPage() async {
    userEmail = FirebaseAuth.instance.currentUser?.email;
    List<Cart?> carts = await _cartDataService.fetchUsersCart(userEmail!);
    List<CartProduct> cartProducts = [];
    for (int i = 0; i < carts.length; i++) {
      Product? product = await _productDataService.fetchProductsById(
          carts[i]!.productId, carts[i]!.category);
      CartProduct cartProduct =
          CartProduct.mapProductToCartProduct(carts[i]?.id, product);
      cartProducts.add(cartProduct);
    }

    state = CartIdleState(cartProductList: cartProducts);
  }

  void removeFromCart(String? cartId) async {
    if (cartId != null) {
      await _cartDataService.removeCart(userEmail!, cartId);
    }
    initPage();
  }
}
