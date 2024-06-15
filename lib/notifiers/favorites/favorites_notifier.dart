import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/notifiers/favorites/favorites_state.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/services/product_data_service.dart';

part 'favorites_notifier.g.dart';

@Riverpod()
class FavoritesNotifier extends _$FavoritesNotifier {
  final AuthDataService _authDataService = AuthDataService();
  final ProductDataService _productDataService = ProductDataService();
  @override
  FavoritesState build() {
    return FavoritesInitialState();
  }

  initPage() async {
    state = FavoritesLoadingState();
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    UserModel? userModel = await _authDataService.fetchCurrentUser(userEmail!);
    List<String?>? favProductIds = userModel?.favProducts;
    List<Product?> favProducts = [];
    if (favProductIds != null) {
      for (String? id in favProductIds) {
        if ((id != null)) {
          Product product = await _productDataService.fetchProductsById(id);
          favProducts.add(product);
        }
      }
    }
    state = FavoritesLoadedState(favoriteProducts: favProducts);
  }
}
