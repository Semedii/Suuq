import 'package:suuq/models/product.dart';

abstract class ProductState{}

class ProductInitialState extends ProductState{}

class ProductLoadingState extends ProductState{}

class ProductLoadedState extends ProductState{
  final Product product;

  ProductLoadedState({required this.product});
}