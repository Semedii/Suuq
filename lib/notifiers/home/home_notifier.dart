import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_state.dart';
import 'package:suuq/services/cart_manager.dart';
import 'package:suuq/services/product_data_service.dart';
import 'package:suuq/utils/enums/category_enum.dart';
part 'home_notifier.g.dart';

@Riverpod()
class HomeNotifier extends _$HomeNotifier {
  final ProductDataService _productDataService = ProductDataService();
  final CartManager _cartManager = CartManager();
  @override
  HomeState build() {
    return HomeStateInitial();
  }

  initPage() async {
    state = HomeStateLoading();
    List<Product?> cartItems = await _cartManager.getCartItems();
    int numberItemsInCart = cartItems.length;
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
      numberItemsInCart: numberItemsInCart,
      homeAccessories: homeAccessories,
      kitchenAccessories: kitchenAccessories,
      electronics: electronics,
      cosmetics: cosmetics,
      shoes: shoes,
      clothes: clothes,
      gymAccessories: gymAccessories,
    );
  }
  cartItemsUpdated()async{
     List<Product?> cartItems = await _cartManager.getCartItems();
     state = (state as HomeStateLoaded).copyWith(numberItemsInCart: cartItems.length);
  }
}
