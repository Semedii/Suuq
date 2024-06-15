import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/utils/enums/language.dart';

class AuthDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserModel?> fetchCurrentUser(String email) async {
    try {
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
    } catch (e) {
      print("error happened $e");
    }
    return null;
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

  Future<void> addProductToFav(String email, String productId)async {
    final userRef = db
        .collection('users')
        .doc('customersDoc')
        .collection("customers")
        .doc(email);
    try {
      await userRef.update({
        'favproducts': FieldValue.arrayUnion([productId]),
      });
      print('Product added to favorites successfully.');
    } catch (e) {
      print('Error adding product to favorites: $e');
    }
  }

Future<bool> isProductInFav(String email, String id) async {
   final userRef = db
        .collection('users')
        .doc('customersDoc')
        .collection("customers")
        .doc(email);

  DocumentSnapshot snapshot = await userRef.get();
  if (snapshot.exists) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>? ;

    if (data != null && data.containsKey('favproducts') && data['favproducts'] is List) {
  
      List<dynamic> favProducts = data['favproducts'];

      return favProducts.contains(id);
    }
  }
  return false;
}


    Future<void> removeProductFromFav(String email, String productId)async {
    final userRef = db
        .collection('users')
        .doc('customersDoc')
        .collection("customers")
        .doc(email);
   try {
    await userRef.update({
      'favproducts': FieldValue.arrayRemove([productId]),
    });
    print('Product removed from favorites successfully.');
  } catch (e) {
    print('Error removing product from favorites: $e');
    // Handle any errors as needed
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
