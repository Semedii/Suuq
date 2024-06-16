import 'package:firebase_auth/firebase_auth.dart';
import 'package:suuq/global.dart';
import 'package:suuq/models/user_model.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/firebase_exceptions.dart';
import 'package:suuq/utils/pop_up_message.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthDataService _authDataService = AuthDataService();

  Future<UserModel?> signup(
    String displayName,
    String email,
    String password,
    AppLocalizations localizations,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        await firebaseUser.sendEmailVerification();

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
      FirebaseExceptionHandler.handleFirebaseError(e, localizations);
    } catch (e) {
      print('Error during signup: $e');
    }

    return null;
  }

  Future<UserModel?> login(
      String email, String password, AppLocalizations localizations) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        if (firebaseUser.emailVerified) {
          UserModel? user = await _authDataService.fetchCurrentUser(email);
          if (user == null) {
            logout();
            toastInfo(localizations.customerCheckToast);
          } else {
            return user;
          }
        } else {
          logout();
          toastInfo("please verify your email to log in");
        }
      }
    } on FirebaseException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e, localizations);
    }
    return null;
  }

  Future<void> changePassword(
      String newPassword, AppLocalizations localizations) async {
    final userCredential = FirebaseAuth.instance.currentUser;
    try {
      await userCredential?.updatePassword(newPassword);
    } on FirebaseException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e, localizations);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Global.storageService.clear();
  }
}
