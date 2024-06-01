import 'package:suuq/models/product.dart';

abstract class StoreState {}

class StoreInitialState extends StoreState {}

class StoreLoadingState extends StoreState {}

class StoreLoadedState extends StoreState {
  final List<Product?> products;
  final bool nextBatchLoading;
  final bool noMoreToFetch;

  StoreLoadedState(
      {required this.products,
      this.nextBatchLoading = false,
      this.noMoreToFetch = false});

  StoreLoadedState copyWith({
    List<Product?>? products,
    bool? nextBatchLoading,
    bool? noMoreToFetch,
  }) {
    return StoreLoadedState(
      products: products ?? this.products,
      nextBatchLoading: nextBatchLoading ?? this.nextBatchLoading,
      noMoreToFetch: noMoreToFetch ?? this.noMoreToFetch,
    );
  }
}
