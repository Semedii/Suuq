import 'package:suuq/models/product.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final Product product;
  final bool isAddingToFav;

  ProductLoadedState({required this.product, this.isAddingToFav = false});

  ProductLoadedState copyWith({Product? product, bool? isAddingToFav}) {
    return ProductLoadedState(
      product: product ?? this.product,
      isAddingToFav: isAddingToFav ?? this.isAddingToFav,
    );
  }
}
