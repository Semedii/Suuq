import 'package:suuq/models/order.dart';

abstract class OrdersState{}

class OrdersInitialState extends OrdersState{}

class OrdersLoadingState extends OrdersState{}

class OrdersLoadedState extends OrdersState{
  final List<OrderModel?> orders;

  OrdersLoadedState({required this.orders});
}
