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
    for (Product? product in cartList) {
      if (product != null) {
        totalPrice += product.price;
      }
    }
    return totalPrice;
  }
}
class CartLoadingState extends CartState {}
