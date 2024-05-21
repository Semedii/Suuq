import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/cart.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_state.dart';
import 'package:suuq/services/cart_data_service.dart';
import 'package:suuq/services/product_data_service.dart';
import 'package:suuq/utils/enums/category_enum.dart';
import 'package:suuq/utils/pop_up_message.dart';
part 'home_notifier.g.dart';

@Riverpod()
class HomeNotifier extends _$HomeNotifier {
  final ProductDataService _productDataService = ProductDataService();
  final CartDataService _cartDataService = CartDataService();

  late String? userEmail;
  @override
  HomeState build() {
    return HomeStateInitial();
  }

  initPage() async {
    state = HomeStateLoading();
    userEmail = FirebaseAuth.instance.currentUser?.email;
    List<Cart?> cartItems = await _cartDataService.fetchUsersCart(userEmail!);
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

  _cartItemsUpdated() async {
    List<Cart?> cartItems = await _cartDataService.fetchUsersCart(userEmail!);
    state = (state as HomeStateLoaded)
        .copyWith(numberItemsInCart: cartItems.length);
  }

  void addToCart(Product product) async {
    List<Cart?> carts = await _cartDataService.fetchUsersCart(userEmail!);
    List<String> sellersInCart = [];
    for (int i = 0; i < carts.length; i++) {
      Product? product = await _productDataService.fetchProductsById(
          carts[i]!.productId, carts[i]!.category);
      sellersInCart.add(product.sellerName);
    }
    if (sellersInCart.isNotEmpty &&
        !sellersInCart.contains(product.sellerName)) {
      toastInfo("Products from other stores are there");
    } else {
      Cart cart = Cart(
          customerEmail: userEmail!,
          productId: product.id,
          category: product.category);
      await _cartDataService.addNewProductToCart(cart);
      await _cartItemsUpdated();
    }
  }
}
