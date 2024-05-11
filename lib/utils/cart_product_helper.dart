import 'package:firebase_auth/firebase_auth.dart';
import 'package:suuq/models/cart.dart';
import 'package:suuq/models/product.dart';

class CartProductHelper {
  static Cart getCartFromProduct(Product product) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    Cart cart = Cart(
        customerEmail: userEmail!,
        productId: product.id,
        category: product.category);

    return cart;
  }

  static List<Product?> getProductsFromCart(List<Cart?> cartList) {
    // if (cartList.isNotEmpty) {
    //   return cartList
    //       .map((cart) => Product(
    //           sellerName: cart!.sellerName,
    //           imageUrl: [cart.firstImage],
    //           description: cart.productDescription,
    //           price: cart.price,
    //           category: cart.productCategory))
    //       .toList();
    // }
    return [];
  }
}
