import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/cart.dart';

class CartDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> addNewProductToCart(Cart cart) async {
    try {
      final docRef = db
          .collection("cart")
          .withConverter(
            fromFirestore: Cart.fromFirestore,
            toFirestore: (Cart cart, options) => cart.toFirestore(),
          )
          .doc();
      await docRef.set(cart);
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<List<Cart?>> fetchUsersCart(String email) async {
    try {
      final collectionRef = db.collection("cart").withConverter(
            fromFirestore: Cart.fromFirestore,
            toFirestore: (cart, _) => cart.toFirestore(),
          );
      final querySnapshot =
          await collectionRef.where("customerEmail", isEqualTo: email).get();
      List<Cart> carts =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return carts ;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
