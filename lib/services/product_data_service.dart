import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/product.dart';

class ProductDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Product>?> fetchAllProducts() async {
    try {
      final collectionRef = db.collection("products").withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (product, _) => product.toFirestore(),
          );

      final querySnapshot = await collectionRef.get();
      List<Product> products = querySnapshot.docs.map((doc) => doc.data()).toList();
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return null;
    }
  }

  Future<List<Product?>> fetchProductsByCategory(String category) async {
    try {
      final collectionRef = db
          .collection("products")
          .where('category', isEqualTo: category.toLowerCase())
          .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (product, _) => product.toFirestore(),
          );

      final querySnapshot = await collectionRef.get();
      List<Product> products = querySnapshot.docs.map((doc) => doc.data()).toList();
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    final docRef = db
        .collection("products")
        .withConverter(
          fromFirestore: Product.fromFirestore,
          toFirestore: (Product item, options) => product.toFirestore(),
        )
        .doc();
    await docRef.set(product);
  }
}
