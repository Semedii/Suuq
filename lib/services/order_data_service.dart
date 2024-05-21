import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/order.dart';

class OrderDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> addNewOrder(OrderModel order) async {
    try {
      final docRef = db
          .collection("orders")
          .withConverter(
            fromFirestore: OrderModel.fromFirestore,
            toFirestore: (OrderModel order, options) => order.toFirestore(),
          )
          .doc();
      await docRef.set(order);
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<List<OrderModel?>> fetchCurrentUsersOrders(String email) async {
    try {
      final collectionRef = db
          .collection("orders")
          .orderBy('orderedDate', descending: true)
          .withConverter(
            fromFirestore: OrderModel.fromFirestore,
            toFirestore: (order, _) => order.toFirestore(),
          );
      final querySnapshot = await collectionRef
          .where("customer.email", isEqualTo: email)
          .where("status", isNotEqualTo: "delivered")
          .get();
      List<OrderModel> orders =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return orders;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  Future<List<OrderModel?>> fetchPastUsersOrders(String email) async {
    try {
      final collectionRef = db
          .collection("orders")
          .orderBy('orderedDate', descending: true)
          .withConverter(
            fromFirestore: OrderModel.fromFirestore,
            toFirestore: (order, _) => order.toFirestore(),
          );
      final querySnapshot = await collectionRef
          .where("customer.email", isEqualTo: email)
          .where("status", isEqualTo: "delivered")
          .get();
      List<OrderModel> orders =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return orders;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }
}
