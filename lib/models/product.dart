import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/product_questions.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class Product {
  final String id;
  final String sellerName;
  final String sellerEmail;
  final List<String?> imageUrl;
  final String description;
  final double price;
  final Category category;
  final List<Map<String, String>>? features;
  final String? extraDescription;
  final List<ProductQuestions?> questions;

  Product({
    this.id = "",
    required this.sellerName,
    required this.sellerEmail,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.category,
    this.extraDescription,
    this.features,
    this.questions = const [],
  });

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final bool isPriceString = data?['price'].runtimeType == String;

    List<Map<String, String>> productFeatures = [];

    if (data?['features'] != null) {
      for (var feature in data?['features']) {
        if (feature is Map<dynamic, dynamic>) {
          Map<String, String> convertedFeature = {};
          feature.forEach((key, value) {
            convertedFeature[key.toString()] = value.toString();
          });
          productFeatures.add(convertedFeature);
        }
      }
    }

    return Product(
      id: snapshot.id,
      sellerName: data?['seller_name'],
      sellerEmail: data?['seller_email'],
      imageUrl: data?['image'].cast<String>(),
      description: data?['description'],
      price: isPriceString ? double.parse(data?['price']) : data?['price'],
      category: getCategoryFromString(data?['category']),
      features: productFeatures,
      extraDescription: data?['extra_description'],
      questions: (data?['questions'] as List<dynamic>?)
              ?.map((questions) => ProductQuestions.fromJson(questions))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "seller_name": sellerName,
      "seller_email": sellerEmail,
      "image": imageUrl,
      "description": description,
      "price": price.toStringAsFixed(2),
      "category": categoryToString(category),
      "extra_description": extraDescription,
       "questions": questions
          .map((question) => question?.toFirestore())
          .toList(),
      'features': features != null
          ? List<dynamic>.from(
              features!.map((feature) => Map<String, dynamic>.from(feature)))
          : null,
    };
  }

  //for sharedpref and orderservice
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] ?? "",
        sellerName: json['seller_name'],
        sellerEmail: json['seller_email'],
        description: json['description'],
        imageUrl: json['image'].cast<String>(),
        price: double.parse(json['price']),
        extraDescription: json['extra_description'],
        category: getCategoryFromString(json['category']),
        features: json['features']);
  }

  Product copyWith({List<String?>? imageUrl}) {
    return Product(
      id: id,
      sellerName: sellerName,
      sellerEmail: sellerEmail,
      imageUrl: imageUrl ?? [],
      description: description,
      price: price,
      category: category,
      features: features,
      questions: questions,
      extraDescription: extraDescription
    );
  }
}
