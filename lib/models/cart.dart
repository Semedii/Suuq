import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class Cart {
  final String id;
  final String customerEmail;
  final String productId;
  final String productDescription;
  final String sellerName;
  final double price;
  final String? firstImage;
  final Category productCategory;

  Cart({
     this.id="",
    required this.customerEmail,
    required this.productId,
    required this.productDescription,
    required this.sellerName,
    required this.price,
    required this.productCategory,
    this.firstImage,
  });

  factory Cart.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Cart(
        id: snapshot.id,
        customerEmail: data?['customerEmail'],
        productId: data?['productId'],
        productDescription: data?['productDescription'],
        sellerName: data?['sellerName'],
        price: data?['price'],
        productCategory: getCategoryFromString(data?['productCategory']),
        firstImage: data?['firstImage']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      'customerEmail': customerEmail,
      "productId": productId,
      "productDescription": productDescription,
      "sellerName": sellerName,
      "price": price,
      'firstImage': firstImage,
      'productCategory': categoryToString(productCategory),
    };
  }
}
