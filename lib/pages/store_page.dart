import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/product_card.dart';
import 'package:suuq/notifiers/store/store_notifier.dart';
import 'package:suuq/notifiers/store/store_state.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/string_utilities.dart';
import '../utils/enums/category_enum.dart';

@RoutePage()
class StorePage extends ConsumerWidget {
  StorePage({
    required this.sellerEmail,
    required this.storename,
    super.key,
  });
  final String storename;
  final String sellerEmail;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * .2;
      if (maxScroll - currentScroll <= delta) {
        ref.read(storeNotifierProvider.notifier).fetchNextBach(sellerEmail);
      }
    });
    final storeState = ref.watch(storeNotifierProvider);
    return Scaffold(
        appBar: AppBar(title: Text(storename)),
        body: _mapStateToWidget(context, storeState, ref));
  }

  Widget _mapStateToWidget(
    BuildContext context,
    StoreState state,
    WidgetRef ref,
  ) {
    if (state is StoreInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(storeNotifierProvider.notifier).initPage(sellerEmail);
      });
    } else if (state is StoreLoadedState) {
      return _buildPageBody(context, state, ref);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Column _buildPageBody(
    BuildContext context,
    StoreLoadedState state,
    WidgetRef ref,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 65,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Category.values.length,
              itemBuilder: (context, index) {
                final currentCategory =
                    categoryToString(Category.values[index]);
                bool isSelected = state.filters.isFilterActive(currentCategory);
                return Padding(
                  padding: AppStyles.edgeInsetsH4,
                  child: ChoiceChip(
                    showCheckmark: false,
                    selectedColor: Colors.black,
                    disabledColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    side: const BorderSide(color: Colors.black),
                    label: Text(currentCategory),
                    selected: isSelected,
                    onSelected: (value)=> ref
                        .read(storeNotifierProvider.notifier)
                        .onFiltersApplied(value),
                  ),
                );
              },
            )),
        Expanded(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = state.products[index];
                  if (product != null) {
                    return ProductCard(product: product);
                  }
                  return const Text("no items found");
                }, childCount: state.products.length),
              ),
              if (state.nextBatchLoading) ...{
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppStyles.edgeInsetsB24,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              },
              if (state.noMoreToFetch) ...{
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppStyles.edgeInsetsB24,
                    child: Center(
                      child: Text(
                          localizations.end + StringUtilities.exclamationMark),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ],
    );
  }
}
