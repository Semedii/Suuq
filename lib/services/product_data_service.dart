import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class ProductDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Product>?> fetchAllProducts() async {
    try {
      final collectionRef = db.collection("products").withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (product, _) => product.toFirestore(),
          );

      final querySnapshot = await collectionRef.get();
      List<Product> products =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return null;
    }
  }

  Future<Product> fetchProductsById(String id, Category category) async {
    final stirngCategory = categoryToString(category);
    final collectionRef =
        db.collectionGroup(stirngCategory.toLowerCase()).withConverter(
              fromFirestore: Product.fromFirestore,
              toFirestore: (product, _) => product.toFirestore(),
            );

    final querySnapshot = await collectionRef.get();
    final prodData =
        querySnapshot.docs.firstWhere((element) => element.id == id);
    return prodData.data();
  }

  Future<List<Product?>> fetchProductsByCategory(String category) async {
    try {
      final collectionRef =
          db.collectionGroup(category.toLowerCase()).withConverter(
                fromFirestore: Product.fromFirestore,
                toFirestore: (product, _) => product.toFirestore(),
              );

      final querySnapshot = await collectionRef.get();
      List<Product> products =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
