import 'package:suuq/models/product.dart';
import 'package:suuq/utils/category_search_filters.dart';

abstract class StoreState {}

class StoreInitialState extends StoreState {}

class StoreLoadingState extends StoreState {}

class StoreLoadedState extends StoreState {
  final List<Product?> products;
  final bool nextBatchLoading;
  final bool noMoreToFetch;
  final CategorySearchFilters filters;

  StoreLoadedState({
    required this.products,
    required this.filters,
    this.nextBatchLoading = false,
    this.noMoreToFetch = false,
  });

  StoreLoadedState copyWith({
    List<Product?>? products,
    CategorySearchFilters? filters,
    bool? nextBatchLoading,
    bool? noMoreToFetch,
  }) {
    return StoreLoadedState(
      products: products ?? this.products,
      filters: filters ?? this.filters,
      nextBatchLoading: nextBatchLoading ?? this.nextBatchLoading,
      noMoreToFetch: noMoreToFetch ?? this.noMoreToFetch,
    );
  }
}
