import 'package:suuq/models/product.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<Product?> products;
  final bool fetchingNextData;

  CategoryLoadedState({required this.products, this.fetchingNextData = false});

  CategoryLoadedState copyWith({
    List<Product?>? products,
    bool? fetchingNextData,
  }) {
    return CategoryLoadedState(
      products: products ?? this.products,
      fetchingNextData: fetchingNextData ?? this.fetchingNextData,
    );
  }
}
