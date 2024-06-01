import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/services/image_data_service.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class ProductDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  late DocumentSnapshot lastDocument;

  Future<List<Product?>> fetchAllProductsByStore(String sellerEmail) async {
    try {
      final collectionRef = db.collection("products").where("seller_email", isEqualTo: sellerEmail).withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (product, _) => product.toFirestore(),
          );

      final querySnapshot = await collectionRef.get();
      List<Product> products =
          querySnapshot.docs.map((doc) => doc.data()).toList();
     return  _getProductsWithImages(products);
    } catch (e) {
      print("Error fetching productssss: $e");
      return [];
    }
  }

  Future<Product> fetchProductsById(String id, Category category) async {
    final stirngCategory = categoryToString(category);
    final collectionRef = db
        .collection('products')
        .where("category", isEqualTo: stirngCategory.toLowerCase())
        .withConverter(
          fromFirestore: Product.fromFirestore,
          toFirestore: (product, _) => product.toFirestore(),
        );

    final querySnapshot = await collectionRef.get();
    final prodData =
        querySnapshot.docs.firstWhere((element) => element.id == id);
    List<String> newImageUrls = [];
    for (String? imageUrl in prodData.data().imageUrl) {
      var newImageUrl = await ImageDataService().retrieveImageUrl(imageUrl);
      newImageUrls.add(newImageUrl);
    }
    Product product = prodData.data().copyWith(imageUrl: newImageUrls);
    return product;
  }

  Future<List<Product?>> fetchHomePageProducts(String category) async {
    try {
      final collectionRef = db
          .collection('products')
          .where("category", isEqualTo: category.toLowerCase())
          .limit(10)
          .orderBy(FieldPath.documentId);

      var query = await collectionRef.get();
      lastDocument = query.docs.last;

      final querySnapshot = await collectionRef
          .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (product, _) => product.toFirestore(),
          )
          .get();

      List<Product> products =
          querySnapshot.docs.map((doc) => doc.data()).toList();
       return  _getProductsWithImages(products);
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<Product?>> fetchNextBatchProducts(
      String category, Product product) async {
    try {
      final collectionRef = db
          .collection('products')
          .where("category", isEqualTo: category.toLowerCase())
          .limit(20)
          .orderBy(FieldPath.documentId)
          .startAfterDocument(lastDocument);

      var query = await collectionRef.get();
      lastDocument = query.docs.last;

      final querySnapshot = await collectionRef
          .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (product, _) => product.toFirestore(),
          )
          .get();
      List<Product> products =
          querySnapshot.docs.map((doc) => doc.data()).toList();
        return  _getProductsWithImages(products);
    } catch (e) {
      print("Error fetching products: ${e.toString()}");
      return [];
    }
  }

  Future<List<Product>> _getProductsWithImages(List<Product> products) async {
    final List<Product> productsWithImages = [];
    for (Product product in products) {
      List<String> newImageUrls = [];
      for (String? imageUrl in product.imageUrl) {
        var newImageUrl = await ImageDataService().retrieveImageUrl(imageUrl);
        newImageUrls.add(newImageUrl);
      }
      product = product.copyWith(imageUrl: newImageUrls);
      productsWithImages.add(product);
    }
    return productsWithImages;
  }
}
