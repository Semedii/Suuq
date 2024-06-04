import 'package:cloud_firestore/cloud_firestore.dart';

class MerchantData {
  final int zaadNumber;
  final int edahabNumber;
  final String contactNumber;
  final int exchangeRate;

  MerchantData({
    required this.zaadNumber,
    required this.edahabNumber,
    required this.contactNumber,
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
      contactNumber: data?['contactNumber'],
      exchangeRate: data?['exchangeRate'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "zaadNumber": zaadNumber,
      "edahabNumber": edahabNumber,
      "contactNumber": contactNumber,
      "exchangeRate": exchangeRate,
    };
  }
}
