import 'package:suuq/models/cart_product.dart';
abstract class CartState {}

class CartInitialState extends CartState{}

class CartIdleState extends CartState {
  final List<CartProduct?> cartProductList;

  CartIdleState({this.cartProductList = const []});

  CartIdleState copyWith({List<CartProduct?>? cartProductList}) {
    return CartIdleState(
      cartProductList: cartProductList ?? this.cartProductList,
    );
  }

double get getTotalPrice {
    double totalPrice = 0.0;
    for (CartProduct? cartProductList in cartProductList) {
      if (cartProductList != null) {
        totalPrice += cartProductList.price;
      }
    }
    return totalPrice;
  }
}
class CartLoadingState extends CartState {}
