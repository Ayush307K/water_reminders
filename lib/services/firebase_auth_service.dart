import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Create a new user with email and password
  Future<bool> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print('Error creating account: ${e.message}');
      return false;
    }
  }

  // Sign in with email and password
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print('Error signing in: ${e.message}');
      return false;
    }
  }

  // Sign out the current user
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error signing out: ${e.toString()}');
    }
  }

  // Check if the user is currently logged in
  Future<bool> isUserLoggedIn() async {
    User? user = _firebaseAuth.currentUser;
    return user != null;
  }

  // Get the current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
