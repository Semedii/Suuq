import 'package:suuq/models/product.dart';

abstract class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final List<Product?> homeAccessories;
  final List<Product?> electronics;
  final List<Product?> kitchenAccessories;
  final List<Product?> shoes;
  final List<Product?> cosmetics;

  HomeStateLoaded(
      {this.homeAccessories = const [],
      this.electronics = const [],
      this.kitchenAccessories = const [],
      this.shoes = const [],
      this.cosmetics = const []});

  HomeStateLoaded copyWith({
    List<Product?>? homeAccessories,
    List<Product?>? electronics,
    List<Product?>? kitchenAccessories,
    List<Product?>? shoes,
    List<Product?>? cosmetics,
  }) {
    return HomeStateLoaded(
      homeAccessories: homeAccessories ?? this.homeAccessories,
      electronics: electronics ?? this.electronics,
      kitchenAccessories: kitchenAccessories ?? this.kitchenAccessories,
      shoes: shoes ?? this.shoes,
      cosmetics: cosmetics ?? this.cosmetics,
    );
  }
}
