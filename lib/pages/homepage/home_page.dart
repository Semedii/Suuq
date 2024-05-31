import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:suuq/components/product_card.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_notifier.dart';
import 'package:suuq/notifiers/home/home_state.dart';
import 'package:suuq/pages/homepage/home_page_app_bar.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/enums/category_enum.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    return _mapStateToWidget(context, homeState, ref);
  }

  Widget _mapStateToWidget(
      BuildContext context, HomeState state, WidgetRef ref) {
    if (state is HomeStateInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(homeNotifierProvider.notifier).initPage();
      });
    } else if (state is HomeStateLoaded) {
      return _buildHomePageBody(context, state, ref);
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildHomePageBody(
    BuildContext context,
    HomeStateLoaded state,
    WidgetRef ref,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: HomePageAppBar(
            numberItemsInCart: state.numberItemsInCart,
          ),
        ),
        body: Padding(
          padding: AppStyles.edgeInsets4,
          child: RefreshIndicator(
            onRefresh: () async {
              ref.read(homeNotifierProvider.notifier).initPage();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildNiche(localizations.homeAccessories,
                      state.homeAccessories, context),
                  _buildNiche(
                      localizations.electronics, state.electronics, context),
                  _buildNiche(localizations.kitchenAccessories,
                      state.kitchenAccessories, context),
                  _buildNiche(localizations.shoes, state.shoes, context),
                  _buildNiche(localizations.gymAccessories,
                      state.gymAccessories, context),
                  _buildNiche(
                      localizations.cosmetics, state.cosmetics, context),
                  _buildNiche(localizations.clothes, state.clothes, context),
                ],
              ),
            ),
          ),
        ));
  }

  SizedBox _buildNiche(
    String nicheName,
    List<Product?> products,
    BuildContext context,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nicheName,
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => AutoRouter.of(context).push(
                    CategoryRoute(categoryName: categoryToString(products.first!.category))),
                child: Text(
                  localizations.showAll,
                  style: const TextStyle(
                      color: AppColors.green, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final product = products[index];
                return product != null
                    ? ProductCard(product: product)
                    : const Text("not found");
              },
            ),
          ),
        ],
      ),
    );
  }
}
