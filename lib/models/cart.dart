import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class Cart {
  final String id;
  final String customerEmail;
  final String productId;
  final Category category;

  Cart({
     this.id="",
    required this.customerEmail,
    required this.productId,
    required this.category,
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
        category: getCategoryFromString(data?['category']),);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      'customerEmail': customerEmail,
      "productId": productId,
      'category': categoryToString(category)};
  }
}
