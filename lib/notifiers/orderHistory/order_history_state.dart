import 'package:suuq/models/order.dart';

abstract class OrderHistoryState{}

class OrderHistoryInitialState extends OrderHistoryState{}

class OrderHistoryLoadingState extends OrderHistoryState{}

class OrderHistoryLoadedState extends OrderHistoryState{
  final List<OrderModel?> orders;

  OrderHistoryLoadedState({required this.orders});
}
