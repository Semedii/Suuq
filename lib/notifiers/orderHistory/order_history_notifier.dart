import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/order.dart';
import 'package:suuq/notifiers/orderHistory/order_history_state.dart';
import 'package:suuq/services/order_data_service.dart';

class OrderHistoryNotifier extends StateNotifier<OrderHistoryState> {
  OrderHistoryNotifier() : super(OrderHistoryInitialState());
  final OrderDataService _orderDataService = OrderDataService();

  initPage() async {
    state = OrderHistoryLoadingState();
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    List<OrderModel?> orderList =
        await _orderDataService.fetchPastUsersOrders(userEmail!);
    state = OrderHistoryLoadedState(orders: orderList);
  }
}

final orderHistoryNotifierProvider =
    StateNotifierProvider<OrderHistoryNotifier, OrderHistoryState>(
  (ref) => OrderHistoryNotifier(),
);
