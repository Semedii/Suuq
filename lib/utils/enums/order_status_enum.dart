import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum OrderStatus {
  pending(Icon(Icons.pending_actions), "pending"),
  preparing(Icon(Icons.assignment), "preparing"),
  onTheWay(Icon(Icons.motorcycle), "on the way"),
  delivered(Icon(Icons.check_circle_sharp, color: Colors.green,), "delivered");

  final Icon icon;
  final String name;
  const OrderStatus(this.icon, this.name);

  static OrderStatus fromString(String status) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == status,
    );
  }
  static String translateName(OrderStatus orderStatus, AppLocalizations localizations){
    switch(orderStatus){
      case pending:
        return localizations.pending;
      case preparing:
        return localizations.preparing;
      case onTheWay:
        return localizations.onTheWay;
      case delivered:
        return localizations.delivered;
    }
  }
}
