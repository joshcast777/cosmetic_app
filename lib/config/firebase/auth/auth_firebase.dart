import 'package:firebase_auth/firebase_auth.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/utils/index.dart';

class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? firebaseGetCurrentUser() => FirebaseAuth.instance.currentUser;

  Stream<User?> firebaseOnAuthStateChangesListener() => _firebaseAuth.authStateChanges();

  Future<ApiResponse<void>> firebaseSignInUser(UserAuth userAuth) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: userAuth.email,
        password: userAuth.password,
      );

      return ApiResponse<String>(
        isSuccess: true,
        message: "",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }

  Future<ApiResponse<void>> firebaseSignOutUser() async {
    try {
      await _firebaseAuth.signOut();

      return ApiResponse<void>(
        isSuccess: true,
        message: "",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }

  Future<ApiResponse<void>> firebaseSignUpUser(UserAuth userAuth) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: userAuth.email,
        password: userAuth.password,
      );

      return ApiResponse<String>(
        isSuccess: true,
        message: "",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }
}
