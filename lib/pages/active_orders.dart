import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:suuq/models/order.dart';
import 'package:suuq/notifiers/orders/orders_notifier.dart';
import 'package:suuq/notifiers/orders/orders_state.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';
import 'package:suuq/utils/enums/order_status_enum.dart';
import 'package:suuq/utils/string_utilities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActiveOrders extends ConsumerWidget {
  const ActiveOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(ordersNotifierProvider);
    return _mapStateToWidget(
      context,
      orderState,
      ref,
    );
  }

  Widget _mapStateToWidget(
    BuildContext context,
    OrdersState state,
    WidgetRef ref,
  ) {
    if (state is OrdersInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(ordersNotifierProvider.notifier).initPage();
      });
    } else if (state is OrdersLoadedState) {
      return _buildOrderList(context, state, ref);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildOrderList(
      BuildContext context, OrdersLoadedState state, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(ordersNotifierProvider.notifier).initPage();
      },
      child: Padding(
        padding: AppStyles.edgeInsetsH16V24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localizations.activeOrders,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            state.orders.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return order != null
                            ? _buildOrderCard(context, order)
                            : const SizedBox.shrink();
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                      localizations.noActiveOrders,
                      textAlign: TextAlign.center,
                                        ),
                    ))
          ],
        ),
      ),
    );
  }

  _buildOrderCard(BuildContext context, OrderModel order) {
    return Column(
      children: [
        Card(
            child: Row(
          children: [
            _buildInfo(context, order),
          ],
        ))
      ],
    );
  }

  Expanded _buildInfo(BuildContext context, OrderModel order) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSellerName(
                  order.cartProducts.first?.sellerName.toUpperCase()),
              const Divider(),
              ...order.cartProducts
                  .map((element) => _buildDescription(element?.description)),
              const Divider(),
              _buildPrice(order.totalPrice),
              _buildDateAndStatus(context, order)
            ],
          ),
        ),
      ),
    );
  }

  Text _buildSellerName(String? sellerName) {
    return Text(
      sellerName ?? StringUtilities.emptyString,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDescription(String? description) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        "- $description",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Text _buildPrice(double? totalAmount) {
    return Text(
      "${totalAmount.toString()} \$",
      style: const TextStyle(
        color: AppColors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Row _buildDateAndStatus(BuildContext context, OrderModel? order) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Text(DateFormat("dd/MM/yyyy hh:mm a").format(order!.orderedDate)),
        const Spacer(),
        order.status.icon,
        Text(
          OrderStatus.translateName(order.status, localizations),
          style: const TextStyle(color: Color.fromARGB(255, 101, 92, 7)),
        )
      ],
    );
  }
}
