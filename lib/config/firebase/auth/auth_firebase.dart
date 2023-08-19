import 'package:cosmetic_app/constants/success/success_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/utils/index.dart';

class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? firebaseGetCurrentUser() => FirebaseAuth.instance.currentUser;

  Future<ApiResponse<void>> firebaseDeleteUser(String email, String password) async {
    User? user = firebaseGetCurrentUser();

    try {
      await user?.reauthenticateWithCredential(EmailAuthProvider.credential(
        email: email,
        password: password,
      ));

      await user?.delete();

      return ApiResponse<void>(
        isSuccess: true,
        message: "",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }

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

  Future<ApiResponse<void>> firebaseUpdatePassword(UserApp userApp, String password) async {
    User? user = firebaseGetCurrentUser();

    try {
      await user?.reauthenticateWithCredential(EmailAuthProvider.credential(
        email: userApp.data.email,
        password: userApp.data.password,
      ));

      await user?.updatePassword(password);

      return ApiResponse<void>(
        isSuccess: true,
        message: "$successMessage$successfullyEmailUpdate",
      );
    } catch (e) {
      return errorMessageRequest(e);
    }
  }

  Future<ApiResponse<void>> firebaseUpdateEmail(UserApp userApp, String email) async {
    User? user = firebaseGetCurrentUser();

    try {
      await user?.reauthenticateWithCredential(EmailAuthProvider.credential(
        email: userApp.data.email,
        password: userApp.data.password,
      ));

      await user?.updateEmail(email);

      return ApiResponse<void>(
        isSuccess: true,
        message: "$successMessage$successfullyEmailUpdate",
      );
    } catch (e) {
      return errorMessageRequest(e);
    }
  }
}
