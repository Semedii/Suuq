import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/order.dart';

class OrderDataService{
final FirebaseFirestore db = FirebaseFirestore.instance;
    Future<void> addNewOrder(OrderModel order) async {
    try {
      final docRef = db
          .collection("Orders")
          .withConverter(
             fromFirestore:OrderModel.fromFirestore,
            toFirestore: (OrderModel order, options) => order.toFirestore(),
          )
          .doc();
      await docRef.set(order);
    } catch (e) {
      print("Error fetching products: $e");
    }
  }
}