import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/product_card.dart';
import 'package:suuq/notifiers/favorites/favorites_state.dart';
import 'package:suuq/notifiers/favorites/favorites_notifier.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    final state = ref.watch(favoritesNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text(localizations.favorites)),
      body: _mapStateToWidget(state, ref),
    );
  }

  Widget _mapStateToWidget(FavoritesState state, WidgetRef ref) {
    if (state is FavoritesInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(favoritesNotifierProvider.notifier).initPage();
      });
    } else if (state is FavoritesLoadedState) {
      return _buildPageBody(state);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Padding _buildPageBody(FavoritesLoadedState state) {
    return Padding(
      padding: AppStyles.edgeInsetsH16V24,
      child: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: state.favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = state.favoriteProducts[index];
            if (product != null) {
              return ProductCard(product: product);
            }
            return const Text("no items found");
          },
        ),
      ),
    );
  }
}
