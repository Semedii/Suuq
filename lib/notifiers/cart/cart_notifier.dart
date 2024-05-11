
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/cart.dart';
import 'package:suuq/notifiers/cart/cart_state.dart';
import 'package:suuq/services/cart_data_service.dart';

part 'cart_notifier.g.dart';
@riverpod
class CartNotifier extends _$CartNotifier{
  final CartDataService _cartDataService = CartDataService();
  @override
  CartState build(){
    return CartInitialState();
  }

  void initPage()async{
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
   List<Cart?> carts =await _cartDataService.fetchUsersCart(userEmail!);
   state = CartIdleState(cartList: carts);
  }

  void removeFromCart(Cart cart)async{
   // _cartManager.deleteItemFromCart(product);
    initPage();
  }
}