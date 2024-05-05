
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/cart/cart_state.dart';
import 'package:suuq/services/cart_manager.dart';

part 'cart_notifier.g.dart';
@riverpod
class CartNotifier extends _$CartNotifier{
  final CartManager _cartManager = CartManager();
  @override
  CartState build(){
    return CartInitialState();
  }

  void initPage()async{
    List<Product?> products =await _cartManager.getCartItems();
    state = CartIdleState(cartList: products);
  }

  void removeFromCart(Product product)async{
    _cartManager.deleteItemFromCart(product);
    initPage();
  }
}