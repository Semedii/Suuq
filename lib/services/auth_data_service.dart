import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/user_model.dart';

class AuthDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserModel> fetchCurrentUser(String email) async {
    final collectionRef = db
        .collectionGroup("customers")
        .where('email', isEqualTo: email.toLowerCase())
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (userModel, _) => UserModel().toFirestore(),
        );

    final querySnapshot = await collectionRef.get();
    UserModel user = querySnapshot.docs.map((doc) => doc.data()).first;
    return user;
  }

  Future<void> addNewUser(UserModel user) async {
    try {
      final docRef = db
          .collection("users")
          .doc()
          .collection('customers')
          .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel user, options) => user.toFirestore(),
          )
          .doc();
      await docRef.set(user);
    } catch (e) {
      print("Error fetching products: $e");
    }
  }
}