import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/feature.dart';
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
  final String? extraDescription;
  final List<Feature?>? features;
  final bool isFav;
  final List<ProductQuestions?> questions;

  Product({
    this.id = "",
    required this.sellerName,
    required this.sellerEmail,
    required this.imageUrl,
    required this.description,
    this.extraDescription,
    required this.price,
    required this.category,
    this.isFav=false,
    this.features,
    this.questions = const [],
  });

factory Product.fromFirestore(
  DocumentSnapshot<Map<String, dynamic>> snapshot,
  SnapshotOptions? options,
) {
  final data = snapshot.data();
  List<Feature>? featuresList = [];
  if (data?['features'] != null) {
    List<dynamic> featuresData = data?['features'];
    featuresList = featuresData.map((dynamic feature) {
      return Feature(title: feature['title'].toString(), value: feature['value'].toString());
     
    }).toList();
  }

  return Product(
    id: snapshot.id,
    sellerName: data?['seller_name'],
    sellerEmail: data?['seller_email'],
    imageUrl: data?['image'].cast<String>(),
    description: data?['description'],
    price: double.parse(data?['price'].toString() ?? ""),
    category: getCategoryFromString(data?['category']),
    features: featuresList,
    extraDescription: data?['extra_description'],
    isFav: data?['isFav']?? false,
  );
}


  Map<String, dynamic> toFirestore() {
    return {
      "seller_name": sellerName,
      'seller_email': sellerEmail,
      "image": imageUrl,
      "description": description,
      "price": price.toStringAsFixed(2),
      "category": categoryToString(category),
      "extra_description": extraDescription,
      'features': features?.map((feature) => feature?.toJson()).toList(),
      'isFav': isFav,
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
        isFav: json['isFav'],
        features: json['features']);
  }

  Product copyWith({List<String?>? imageUrl, bool? isFav}) {
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
      extraDescription: extraDescription,
      isFav: isFav?? this.isFav,
    );
  }
}
