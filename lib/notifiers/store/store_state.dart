import 'package:suuq/models/product.dart';
import 'package:suuq/utils/category_search_filters.dart';

abstract class StoreState {}

class StoreInitialState extends StoreState {}

class StoreLoadingState extends StoreState {}

class StoreLoadedState extends StoreState {
  final List<Product?> products;
  final bool nextBatchLoading;
  final bool noMoreToFetch;
  final bool isFilterUpdating;
  final CategorySearchFilters filters;

  StoreLoadedState({
    required this.products,
    required this.filters,
    this.isFilterUpdating = false,
    this.nextBatchLoading = false,
    this.noMoreToFetch = false,
  });

  StoreLoadedState copyWith({
    List<Product?>? products,
    CategorySearchFilters? filters,
    bool? isFilterUpdating,
    bool? nextBatchLoading,
    bool? noMoreToFetch,
  }) {
    return StoreLoadedState(
      products: products ?? this.products,
      filters: filters ?? this.filters,
      isFilterUpdating: isFilterUpdating ?? this.isFilterUpdating,
      nextBatchLoading: nextBatchLoading ?? this.nextBatchLoading,
      noMoreToFetch: noMoreToFetch ?? this.noMoreToFetch,
    );
  }
}
