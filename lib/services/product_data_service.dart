import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/services/image_data_service.dart';
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
    List<String> newImageUrls = [];
    for (String? imageUrl in prodData.data().imageUrl) {
      var newImageUrl =
          await ImageDataService().retrieveImageUrl(stirngCategory, imageUrl);
      newImageUrls.add(newImageUrl);
    }
    Product product = prodData.data().copyWith(imageUrl: newImageUrls);
    return product;
  }

  Future<List<Product?>> fetchHomePageProducts(String category) async {
    try {
      final collectionRef =
          db.collectionGroup(category.toLowerCase()).limit(10).withConverter(
                fromFirestore: Product.fromFirestore,
                toFirestore: (product, _) => product.toFirestore(),
              );

      final querySnapshot = await collectionRef.get();
      List<Product> products =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      final List<Product> productsWithImages = [];
      for (Product product in products) {
        List<String> newImageUrls = [];
        for (String? imageUrl in product.imageUrl) {
          var newImageUrl =
              await ImageDataService().retrieveImageUrl(category, imageUrl);
          newImageUrls.add(newImageUrl);
        }
        product = product.copyWith(imageUrl: newImageUrls);
        productsWithImages.add(product);
      }
      return productsWithImages;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
