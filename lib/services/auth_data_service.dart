import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/utils/enums/language.dart';

class AuthDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserModel> fetchCurrentUser(String email) async {
    final collectionRef = db
        .collectionGroup("customers")
        .where('email', isEqualTo: email.toLowerCase())
        .withConverter(
          fromFirestore: (snapshot, option) =>
              UserModel.fromFirestore(snapshot: snapshot),
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
          .doc('customersDoc')
          .collection('customers')
          .withConverter(
            fromFirestore: (snapshot, option) =>
                UserModel.fromFirestore(snapshot: snapshot),
            toFirestore: (UserModel user, options) => user.toFirestore(),
          )
          .doc(user.email);
      await docRef.set(user);
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> updateUserInfo(
      {required String email,
      required String phoneNumber,
      required String address,
      required String name}) async {
    final updatedData = {
      "phone_number": phoneNumber,
      "address": address,
      "name": name
    };
    await db
        .collection('users')
        .doc('customersDoc')
        .collection("customers")
        .doc(email)
        .update(updatedData);
  }

  Future<void> updatePhoneAndAdress({
    required String email,
    String? phoneNumber,
    String? address,
  }) async {
    final updatedData = {"phone_number": phoneNumber, "address": address};
    await db
        .collection('users')
        .doc('customersDoc')
        .collection("customers")
        .doc(email)
        .update(updatedData);
  }

  Future<void> updateLanguage({
    required String email,
    required Language language,
  }) async {
    final updatedData = {"language": languageToString(language)};
    await db
        .collection('users')
        .doc('customersDoc')
        .collection("customers")
        .doc(email)
        .update(updatedData);
  }
}
