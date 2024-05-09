import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class Product {
  final String id;
  final String sellerName;
  final List<String?> imageUrl;
  final String description;
  final double price;
  final Category category;

  Product({
    this.id='',
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
      id: snapshot.id,
      sellerName: data?['seller_name'],
      imageUrl: data?['image'].cast<String>(),
      description: data?['description'],
      price: double.parse(data?['price']),
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
    Map<String, dynamic> toJson() {
    return {
      "id": id,
      "seller_name": sellerName,
      "image": imageUrl,
      "description": description,
      "price": price.toStringAsFixed(2),
      "category": categoryToString(category),
    };
  }
  //for sharedpref
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sellerName: json['seller_name'],
      description: json['description'],
      imageUrl: json['image'].cast<String>(),
      price: double.parse(json['price']),
      category: getCategoryFromString(json['category']),
    );
  }

}
