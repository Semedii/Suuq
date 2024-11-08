import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/models/product_questions.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/services/image_data_service.dart';

class ProductDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  late DocumentSnapshot lastDocument;

  Future<List<Product?>> fetchFirstBatchProductsByStore(
    String sellerEmail,
  ) async {
    try {
      final collectionRef = db
          .collection("products")
          .where("seller_email", isEqualTo: sellerEmail)
          .limit(20)
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
      return _getProductsWithImagesAndIsFavs(products);
    } catch (e) {
      print("Error fetching productssss: $e");
      return [];
    }
  }

  Future<List<Product?>> fetchNextBatchProductsByStore(
    String sellerEmail,
  ) async {
    try {
      final collectionRef = db
          .collection('products')
          .where("seller_email", isEqualTo: sellerEmail)
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
      return _getProductsWithImagesAndIsFavs(products);
    } catch (e) {
      print("Error fetching products: ${e.toString()}");
      return [];
    }
  }

  Future<List<Product?>> fetchFirstBatchProductsByStoreCategoy(
    String sellerEmail,
    String category,
  ) async {
    try {
      final collectionRef = db
          .collection("products")
          .where("seller_email", isEqualTo: sellerEmail)
          .where("category", isEqualTo: category)
          .limit(20)
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
      return _getProductsWithImagesAndIsFavs(products);
    } catch (e) {
      print("Error fetching productssss: $e");
      return [];
    }
  }

  Future<List<Product?>> fetchNextBatchProductsByStoreCategoy(
    String sellerEmail,
    String category,
  ) async {
    try {
      final collectionRef = db
          .collection("products")
          .where("seller_email", isEqualTo: sellerEmail)
          .where("category", isEqualTo: category)
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
      return _getProductsWithImagesAndIsFavs(products);
    } catch (e) {
      print("Error fetching productssss: $e");
      return [];
    }
  }

  Future<Product> fetchProductsById(String id) async {
      var email = FirebaseAuth.instance.currentUser?.email;
    final collectionRef = db
        .collection('products')
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
     bool isFav = await AuthDataService().isProductInFav(email!, id);
    Product product = prodData.data().copyWith(imageUrl: newImageUrls, isFav: isFav);
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
      return _getProductsWithImagesAndIsFavs(products);
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<Product?>> fetchNextBatchProducts(String category) async {
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
      return _getProductsWithImagesAndIsFavs(products);
    } catch (e) {
      print("Error fetching products: ${e.toString()}");
      return [];
    }
  }

Future<List<Product>> _getProductsWithImagesAndIsFavs(List<Product> products) async {
  var email = FirebaseAuth.instance.currentUser?.email;
  final List<Product> productsWithImages = [];

  List<Future<List<String>>> imageFutures = products.map((product) =>
      Future.wait(product.imageUrl.map((imageUrl) =>
          ImageDataService().retrieveImageUrl(imageUrl)))).toList();

  List<List<String>> imageUrlsList = await Future.wait(imageFutures);

  List<Future<bool>> favFutures = products.map((product) =>
      AuthDataService().isProductInFav(email!, product.id)).toList();

  List<bool> isFavList = await Future.wait(favFutures);

  for (int i = 0; i < products.length; i++) {
    Product product = products[i];
    List<String> newImageUrls = imageUrlsList[i];
    bool isFav = isFavList[i];
    product = product.copyWith(imageUrl: newImageUrls, isFav: isFav);
    productsWithImages.add(product);
  }
  return productsWithImages;
}

  Future<void> addNewQuestion({
    required String productId,
    required ProductQuestions question,
  }) async {
    final productDoc = db.collection('products').doc(productId);
    final productSnapshot = await productDoc.get();
    if (productSnapshot.exists) {
      final productData = productSnapshot.data();
      final questions = productData?['questions'] ?? [];
      questions.add(question.toFirestore());

      await productDoc.update({'questions': questions});
    }
  }
}
