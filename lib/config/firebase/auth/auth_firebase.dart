import 'package:cosmetic_app/constants/success/success_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/utils/index.dart';

/// Clase que gestiona la autenticación del usuario
class AuthFirebase {
  /// Instancia de Firebase Authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Obtiene el usuario autenticado actual
  User? firebaseGetCurrentUser() => FirebaseAuth.instance.currentUser;

  /// Elimina un usuario de Firebase Authentication
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

  /// Función que está a la escucha de cuando el estado de la autenticación ha cambiado
  Stream<User?> firebaseOnAuthStateChangesListener() => _firebaseAuth.authStateChanges();

  /// Inicia sesión a un usuario en Firebase Authentication
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

  /// Cierra la sesión de un usuario en Firebase Authentication
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

  /// Registra a un usuario en Firebase Authentication
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

  /// Actualiza la contraseña de un usuario en Firebase Authentication
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
        message: "",
      );
    } catch (e) {
      return errorMessageRequest(e);
    }
  }

  /// Actualiza el correo de un usuario en Firebase Authentication
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
        message: "",
      );
    } catch (e) {
      return errorMessageRequest(e);
    }
  }
}
