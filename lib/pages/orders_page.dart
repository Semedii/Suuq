import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:suuq/models/order.dart';
import 'package:suuq/notifiers/orders/orders_notifier.dart';
import 'package:suuq/notifiers/orders/orders_state.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

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
      return _buildOrderList(state);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Padding _buildOrderList(OrdersLoadedState state) {
    return Padding(
      padding: AppStyles.edgeInsetsH16V24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state.orders.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      final order = state.orders[index];
                      return order != null
                          ? _buildOrderCard(order)
                          : const SizedBox.shrink();
                    },
                  ),
                )
              : const Center(
                  child: Text(
                  "No Orders found. Please place your first order and win a price",
                  textAlign: TextAlign.center,
                ))
        ],
      ),
    );
  }

  _buildOrderCard(OrderModel order) {
    return Column(
      children: [
        Card(
            child: Row(
          children: [
            _buildInfo(order),
          ],
        ))
      ],
    );
  }

  Expanded _buildInfo(OrderModel order) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...order.products
                  .map((element) => _buildSellerName(element?.sellerName)),
              ...order.products
                  .map((element) => _buildDescription(element?.description)),
              _buildPrice(order.totalPrice),
              _buildDateAndStatus(order)
            ],
          ),
        ),
      ),
    );
  }

  Text _buildSellerName(String? sellerName) {
    return Text(
      sellerName ?? "",
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

  Row _buildDateAndStatus(OrderModel? order) {
    return Row(
      children: [
        Text(DateFormat("dd/MM/yyyy hh:mm a").format(order!.orderedDate)),
        const Spacer(),
        Text(
          order.status,
          style: const TextStyle(color: Color.fromARGB(255, 101, 92, 7)),
        )
      ],
    );
  }
}
