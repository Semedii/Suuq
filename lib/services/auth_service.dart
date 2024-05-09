import 'package:firebase_auth/firebase_auth.dart';
import 'package:suuq/global.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/utils/firebase_exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthDataService _authDataService = AuthDataService();

  Future<UserModel?> signup(
    String displayName,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = userCredential.user;
      ;
      if (firebaseUser != null) {
        UserModel newUser = UserModel(
          id: firebaseUser.uid,
          name: displayName,
          email: firebaseUser.email,
          phoneNumber: firebaseUser.phoneNumber,
          joinedDate: DateTime.now(),
          avatar: firebaseUser.photoURL,
        );
        await _authDataService.addNewUser(newUser);
        return newUser;
      }
    } on FirebaseException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e);
    }
    return null;
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        UserModel user = await _authDataService.fetchCurrentUser(email);
        return user;
            }
    } on FirebaseException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e);
    }
    return null;
  }

  Future<void> changePassword(String newPassword) async {
    final userCredential = FirebaseAuth.instance.currentUser;
    try {
      await userCredential?.updatePassword(newPassword);
    } on FirebaseException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Global.storageService.clear();
  }
}
