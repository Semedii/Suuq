import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_state.dart';
import 'package:suuq/services/product_data_service.dart';
import 'package:suuq/utils/enums/category_enum.dart';
part 'home_notifier.g.dart';

@Riverpod()
class HomeNotifier extends _$HomeNotifier {
  final ProductDataService _productDataService = ProductDataService();
  @override
  HomeState build() {
    return HomeStateInitial();
  }

  initPage() async {
    state = HomeStateLoading();
    final List<Product?> homeAccessories = await _productDataService
        .fetchProductsByCategory(categoryToString(Category.homeAccessories));
    final List<Product?> electronics = await _productDataService
        .fetchProductsByCategory(categoryToString(Category.electronics));
    final List<Product?> kitchenAccessories = await _productDataService
        .fetchProductsByCategory(categoryToString(Category.kitchenAccessories));
    final List<Product?> shoes = await _productDataService
        .fetchProductsByCategory(categoryToString(Category.shoes));
    final List<Product?> cosmetics = await _productDataService
        .fetchProductsByCategory(categoryToString(Category.cosmetics));
        final List<Product?> clothes = await _productDataService
        .fetchProductsByCategory(categoryToString(Category.clothes));
        final List<Product?> gymAccessories = await _productDataService
        .fetchProductsByCategory(categoryToString(Category.gymAccessories));

    state = HomeStateLoaded(
      homeAccessories: homeAccessories,
      kitchenAccessories: kitchenAccessories,
      electronics: electronics,
      cosmetics: cosmetics,
      shoes: shoes,
      clothes: clothes,
      gymAccessories: gymAccessories,
    );
  }
}
