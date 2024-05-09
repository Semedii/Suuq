import 'package:suuq/models/product.dart';

abstract class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final int numberItemsInCart;
  final List<Product?> homeAccessories;
  final List<Product?> electronics;
  final List<Product?> kitchenAccessories;
  final List<Product?> shoes;
  final List<Product?> cosmetics;
  final List<Product?> gymAccessories;
  final List<Product?> clothes;

  HomeStateLoaded({
    this.numberItemsInCart = 0,
    this.homeAccessories = const [],
    this.electronics = const [],
    this.kitchenAccessories = const [],
    this.shoes = const [],
    this.cosmetics = const [],
    this.gymAccessories = const [],
    this.clothes = const [],
  });

  HomeStateLoaded copyWith({
    List<Product?>? homeAccessories,
    List<Product?>? electronics,
    List<Product?>? kitchenAccessories,
    List<Product?>? shoes,
    List<Product?>? cosmetics,
    List<Product?>? clothes,
    List<Product?>? gymAccessories,
    int? numberItemsInCart,
  }) {
    return HomeStateLoaded(
      homeAccessories: homeAccessories ?? this.homeAccessories,
      electronics: electronics ?? this.electronics,
      kitchenAccessories: kitchenAccessories ?? this.kitchenAccessories,
      shoes: shoes ?? this.shoes,
      cosmetics: cosmetics ?? this.cosmetics,
      gymAccessories: gymAccessories ?? this.gymAccessories,
      clothes: clothes ?? this.clothes,
      numberItemsInCart: numberItemsInCart??this.numberItemsInCart,
    );
  }
}
