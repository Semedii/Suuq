import 'package:suuq/models/product.dart';
import 'package:suuq/utils/enums/category_enum.dart';

class CartProduct {
  final String? id;
  final String sellerName;
  final String? imageUrl;
  final String description;
  final double price;
  final Category category;

  CartProduct({
    this.id,
    required this.sellerName,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.category,
  });

  static mapProductToCartProduct(String? id, Product product) {
    return CartProduct(
      id: id,
      sellerName: product.sellerName,
      imageUrl: product.imageUrl.first,
      description: product.description,
      price: product.price,
      category: product.category,
    );
  }
}
