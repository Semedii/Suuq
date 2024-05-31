import 'package:suuq/models/product.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<Product?> products;

  CategoryLoadedState({required this.products});

  CategoryLoadedState copyWith({List<Product?>? products}) {
    return CategoryLoadedState(products: products ?? this.products);
  }
}
