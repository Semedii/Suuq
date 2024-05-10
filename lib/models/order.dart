import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/utils/enums/currency_enum.dart';
import 'package:suuq/utils/enums/payment_option_enum.dart';
import 'product.dart';

class OrderModel {
  String? id;
  UserModel customer;
  String sendersPhone;
  List<Product?> products;
  double totalPrice;
  String address;
  DateTime orderedDate;
  String status;
  PaymentOption paymentOption;
  Currency currency;

  OrderModel({
    this.id,
    required this.sendersPhone,
    required this.customer,
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.orderedDate,
    this.status = "pending",
    required this.paymentOption,
    required this.currency,
  });

  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    Timestamp orderedDate = data?['orderedDate'];
    return OrderModel(
        id: snapshot.id,
        sendersPhone: data?['sendersPhone'],
        customer: UserModel.fromJson(data?['customer']),
        products: (data?['products'] as List<dynamic>?)
                ?.map((productData) => Product.fromJson(productData))
                .toList() ??
            [],
        totalPrice: double.parse(data?['totalPrice'].toString() ?? "0"),
        address: data?['address'],
        orderedDate: orderedDate.toDate(),
        status: data?['status'],
        currency: getCurrencyFromString(data?['currency']),
        paymentOption: getPaymentOptionFromString(data?['paymentOption']) );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "customer": customer.toFirestore(),
      "products": products.map((product) => product?.toFirestore()).toList(),
      "totalPrice": totalPrice.toStringAsFixed(2),
      "address": address,
      "orderedDate": orderedDate,
      'sendersPhone': sendersPhone,
      'status': status,
      'paymentOption': paymentOptionToString(paymentOption),
      'currency': currencyToString(currency),
    };
  }
}
