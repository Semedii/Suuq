import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class Product {
  final String sellerName;
  final String? imageUrl;
  final String description;
  final double price;
  final Category category;

  Product({
    required this.sellerName,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
      sellerName: data?['seller_name'],
      imageUrl: data?['image'],
      description: data?['description'],
      price: data?['price'].toDouble(),
      category: getCategoryFromString(data?['category']),
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "seller_name": sellerName,
      "image": imageUrl,
      "description": description,
      "price": price.toStringAsFixed(2),
      "category": categoryToString(category),
    };
  }
}