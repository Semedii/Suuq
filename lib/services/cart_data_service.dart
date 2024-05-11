import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/cart.dart';
import 'package:suuq/utils/pop_up_message.dart';

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
      toastInfo("succesfully added to cart");
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
      List<Cart> carts = querySnapshot.docs.map((doc) => doc.data()).toList();
      return carts;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<void> removeCart(String email, String id) async {
    await db.collection('cart').doc(id).delete();
  }

  Future<void> clearCart(String email) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('cart')
          .where("customerEmail", isEqualTo: email)
          .get();

      final List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      final WriteBatch batch = db.batch();

      for (QueryDocumentSnapshot document in documents) {
        batch.delete(document.reference);
      }

      await batch.commit();
    } catch (e) {
      print("Error clearing cart: $e");
    }
  }
}
