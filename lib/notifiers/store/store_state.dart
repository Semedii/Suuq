import 'package:suuq/models/product.dart';

abstract class StoreState {}

class StoreInitialState extends StoreState {}

class StoreLoadingState extends StoreState {}

class StoreLoadedState extends StoreState {
  final List<Product?> products;

  StoreLoadedState({required this.products});

  StoreLoadedState copyWith({List<Product?>? products}) {
    return StoreLoadedState(products: products ?? this.products);
  }
}
