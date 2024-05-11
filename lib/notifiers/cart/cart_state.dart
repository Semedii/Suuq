import 'package:suuq/models/cart.dart';

abstract class CartState {}

class CartInitialState extends CartState{}

class CartIdleState extends CartState {
  final List<Cart?> cartList;

  CartIdleState({this.cartList = const []});

  CartIdleState copyWith({List<Cart?>? cartList}) {
    return CartIdleState(
      cartList: cartList ?? this.cartList,
    );
  }

double get getTotalPrice {
    double totalPrice = 0.0;
    for (Cart? cart in cartList) {
      if (cart != null) {
        totalPrice += cart.price;
      }
    }
    return totalPrice;
  }
}
class CartLoadingState extends CartState {}
