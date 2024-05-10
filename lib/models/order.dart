import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/user_model.dart';
import 'product.dart';

class OrderModel {
  String? id;
  UserModel customer;
  String sendersPhone;
  List<Product?> products;
  double totalPrice;
  String address;
  DateTime orderedDate;

  OrderModel({
    this.id,
    required this.sendersPhone,
    required this.customer,
    required this.products,
    required this.totalPrice,
    required this.address,
   required this.orderedDate,
  });

  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    Timestamp orderedDate = data?['orderedDate'];
    return OrderModel(
      id: snapshot.id,
      sendersPhone: data?['sendersName'],
      customer: UserModel.fromFirestore(snapshot: data?['customer']),
      products: (data?['products'] as List<dynamic>?)
          ?.map((productData) =>
              Product.fromFirestore((productData), options))
          .toList() ?? [],
      totalPrice: double.parse(data?['totalPrice'].toString() ?? "0"),
      address: data?['address'],
      orderedDate: orderedDate.toDate()
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "customer": customer.toFirestore(),
      "products": products.map((product) => product?.toFirestore()).toList(),
      "totalPrice": totalPrice.toStringAsFixed(2),
      "address": address,
      "orderedDate": orderedDate,
      'sendersPhone': sendersPhone    };
  }
}
