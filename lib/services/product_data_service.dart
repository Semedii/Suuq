import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/item.dart';

class ProductDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Item>> fetchAllProducts() async {
    try {
      QuerySnapshot querySnapshot = await db.collection("products").get();
      List<Item> items = querySnapshot.docs.map((docSnapshot) {
        return Item.fromMap(docSnapshot.data() as Map<String, dynamic>);
      }).toList();
      return items;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<Item>> fetchProductsByCategory(String category) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection("products")
          .where('category', isEqualTo: category.toLowerCase())
          .get();
      List<Item> items = querySnapshot.docs.map((docSnapshot) {
        return Item.fromMap(docSnapshot.data() as Map<String, dynamic>);
      }).toList();
      return items;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
