import 'package:suuq/utils/enums/category_enum.dart';

class Item {
  final String sellerName;
  final String? imageUrl;
  final String description;
  final double price;
  final Category category;

  Item({
    required this.sellerName,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    print("aafd $map");
    return Item(
      sellerName: map['seller_name'],
      imageUrl: map['image'],
      description: map['description'],
      price: map['price'].toDouble(),
      category: getCategoryFromString(map['category']),
    );
  }
}
