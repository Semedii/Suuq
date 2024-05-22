import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/cart_product.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/utils/enums/currency_enum.dart';
import 'package:suuq/utils/enums/order_status_enum.dart';
import 'package:suuq/utils/enums/payment_option_enum.dart';

class OrderModel {
  String? id;
  String? sellerName;
  UserModel customer;
  String sendersPhone;
  List<CartProduct?> cartProducts;
  double totalPrice;
  String address;
  DateTime orderedDate;
  OrderStatus status;
  PaymentOption paymentOption;
  Currency currency;

  OrderModel({
    this.id,
    required this.sendersPhone,
    this.sellerName,
    required this.customer,
    required this.cartProducts,
    required this.totalPrice,
    required this.address,
    required this.orderedDate,
    this.status = OrderStatus.pending,
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
        sellerName: data?['sellerName'],
        cartProducts: (data?['cartProducts'] as List<dynamic>?)
                ?.map((cartProductData) =>
                    CartProduct.fromJson(cartProductData))
                .toList() ??
            [],
        totalPrice: double.parse(data?['totalPrice'].toString() ?? "0"),
        address: data?['address'],
        orderedDate: orderedDate.toDate(),
        status: OrderStatus.fromString(data?['status']),
        currency: getCurrencyFromString(data?['currency']),
        paymentOption: getPaymentOptionFromString(data?['paymentOption']));
  }

  Map<String, dynamic> toFirestore() {
    return {
      "customer": customer.toFirestore(),
      "cartProducts": cartProducts
          .map((cartProduct) => cartProduct?.toFirestore())
          .toList(),
      "totalPrice": totalPrice.toStringAsFixed(2),
      "address": address,
      "orderedDate": orderedDate,
      "sellerName": sellerName,
      'sendersPhone': sendersPhone,
      'status': status.name,
      'paymentOption': paymentOptionToString(paymentOption),
      'currency': currencyToString(currency),
    };
  }
}
