import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signup(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}