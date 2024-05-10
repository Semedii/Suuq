import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/merchant_data.dart';

class MerchantDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<MerchantData> fetchMerchantData() async {
    final collectionRef = db.collection("merchantData").withConverter(
          fromFirestore: MerchantData.fromFirestore,
          toFirestore: (merchantData, _) => merchantData.toFirestore(),
        );

    final querySnapshot = await collectionRef.get();
    MerchantData merchantData =
        querySnapshot.docs.map((doc) => doc.data()).first;
    return merchantData;
  }
}
