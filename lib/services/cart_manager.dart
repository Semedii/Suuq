import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/utils/pop_up_message.dart';

class CartManager {
  static const String _cartKey = 'cart';

   Future<void> addItemToCart(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    cart.add(jsonEncode(product.toFirestore()));
    await prefs.setStringList(_cartKey, cart);
    toastInfo("added to cart successfully");
  }
  
   Future<List<Product?>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
   List<Product?> carts = cart.map((productJson) => Product.fromJson(jsonDecode(productJson))).toList();
   return carts;
  }
  Future<void> deleteItemFromCart(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    
    // Find and remove the product from the cart
    cart.removeWhere((productJson) {
      Product? item = Product.fromJson(jsonDecode(productJson));
      return _areProductsEqual(item, product);
    });
    
    await prefs.setStringList(_cartKey, cart);
  }

  // Function to check equality between two product objects
  bool _areProductsEqual(Product? product1, Product? product2) {
    return product1?.description == product2?.description;
  }
}