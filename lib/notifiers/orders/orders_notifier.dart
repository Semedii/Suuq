import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq/models/order.dart';
import 'package:suuq/notifiers/orders/orders_state.dart';
import 'package:suuq/services/order_data_service.dart';

part 'orders_notifier.g.dart';
@Riverpod()
class OrdersNotifier extends _$OrdersNotifier{
  final OrderDataService _orderDataService  = OrderDataService();
  @override
  OrdersState build(){
    return OrdersInitialState();
  }
  initPage()async{
    state = OrdersLoadingState();
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    List<OrderModel?> orderList = await _orderDataService.fetchUsersOrders(userEmail!);
    state = OrdersLoadedState(orders: orderList);
  }
}