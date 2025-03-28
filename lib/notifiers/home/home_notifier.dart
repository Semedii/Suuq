import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/cart.dart';
import 'package:suuq/models/order.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_state.dart';
import 'package:suuq/services/cart_data_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/services/order_data_service.dart';
import 'package:suuq/services/product_data_service.dart';
import 'package:suuq/utils/enums/category_enum.dart';
import 'package:suuq/utils/pop_up_message.dart';
part 'home_notifier.g.dart';

@Riverpod()
class HomeNotifier extends _$HomeNotifier {
  final ProductDataService _productDataService = ProductDataService();
  final OrderDataService _orderDataService = OrderDataService();
  final CartDataService _cartDataService = CartDataService();

  late String? userEmail;
  @override
  HomeState build() {
    return HomeStateInitial();
  }

  initPage() async {
    state = HomeStateLoading();
    userEmail = FirebaseAuth.instance.currentUser?.email;

    // Fetch cart items and active orders concurrently
    var cartItemsFuture = _cartDataService.fetchUsersCart(userEmail!);
    var activeOrdersFuture =
        _orderDataService.fetchCurrentUsersOrders(userEmail!);

    // Fetch products for different categories concurrently
    var homeAccessoriesFuture = _productDataService
        .fetchHomePageProducts(Category.homeAccessories.name);
    var electronicsFuture =
        _productDataService.fetchHomePageProducts(Category.electronics.name);
    var kitchenAccessoriesFuture = _productDataService
        .fetchHomePageProducts(Category.kitchenAccessories.name);
    var shoesFuture =
        _productDataService.fetchHomePageProducts(Category.shoes.name);
    var cosmeticsFuture =
        _productDataService.fetchHomePageProducts(Category.cosmetics.name);
    var clothesFuture =
        _productDataService.fetchHomePageProducts(Category.clothes.name);
    var gymAccessoriesFuture =
        _productDataService.fetchHomePageProducts(Category.gymAccessories.name);

    // Wait for all futures to complete
    List<Cart?> cartItems = await cartItemsFuture;
    List<OrderModel?> activeOrders = await activeOrdersFuture;
    List<Product?> homeAccessories = await homeAccessoriesFuture;
    List<Product?> electronics = await electronicsFuture;
    List<Product?> kitchenAccessories = await kitchenAccessoriesFuture;
    List<Product?> shoes = await shoesFuture;
    List<Product?> cosmetics = await cosmeticsFuture;
    List<Product?> clothes = await clothesFuture;
    List<Product?> gymAccessories = await gymAccessoriesFuture;

    state = HomeStateLoaded(
      numberItemsInCart: cartItems.length,
      numberActiveOrder: activeOrders.length,
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

  void addToCart(Product product, AppLocalizations localizations) async {
    List<Cart?> carts = await _cartDataService.fetchUsersCart(userEmail!);
    List<String> sellersInCart = [];
    for (int i = 0; i < carts.length; i++) {
      Product? product =
          await _productDataService.fetchProductsById(carts[i]!.productId);
      sellersInCart.add(product.sellerName);
    }
    if (sellersInCart.isNotEmpty &&
        !sellersInCart.contains(product.sellerName)) {
      toastInfo(localizations.differentStoresInCart);
    } else {
      Cart cart = Cart(
          customerEmail: userEmail!,
          productId: product.id,
          category: product.category);
      await _cartDataService.addNewProductToCart(
          cart, localizations.succesfullyAddedToCart);
      await _cartItemsUpdated();
    }
  }
}
