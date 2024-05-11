import 'package:suuq/models/product.dart';

abstract class CartState {}

class CartInitialState extends CartState{}

class CartIdleState extends CartState {
  final List<Product?> cartList;

  CartIdleState({this.cartList = const []});

  CartIdleState copyWith({List<Product?>? cartList}) {
    return CartIdleState(
      cartList: cartList ?? this.cartList,
    );
  }

double get getTotalPrice {
    double totalPrice = 0.0;
    for (Product? cart in cartList) {
      if (cart != null) {
        totalPrice += cart.price;
      }
    }
    return totalPrice;
  }
}
class CartLoadingState extends CartState {}
