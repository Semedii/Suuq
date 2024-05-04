import 'package:firebase_auth/firebase_auth.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/utils/firebase_exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signup(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserModel(
          name: firebaseUser.displayName,
          email: firebaseUser.email,
          phoneNumber: firebaseUser.phoneNumber,
          avatar: firebaseUser.photoURL,
        );
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
        return UserModel(
          name: firebaseUser.displayName,
          email: firebaseUser.email,
          phoneNumber: firebaseUser.phoneNumber,
          avatar: firebaseUser.photoURL,
        );
      }
    } on FirebaseException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e);
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
