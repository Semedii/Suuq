import 'package:cloud_firestore/cloud_firestore.dart';

class MerchantData {
  final int zaadNumber;
  final int edahabNumber;
  final int exchangeRate;

  MerchantData({
    required this.zaadNumber,
    required this.edahabNumber,
    required this.exchangeRate,
  });
  factory MerchantData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MerchantData(
      zaadNumber: data?['zaadNumber'],
      edahabNumber: data?['edahabNumber'],
      exchangeRate: data?['exchangeRate'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "zaadNumber": zaadNumber,
      "edahabNumber": edahabNumber,
      "exchangeRate": exchangeRate,
    };
  }
}
