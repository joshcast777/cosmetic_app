import 'package:cosmetic_app/constants/errors/error_constants.dart';
import 'package:cosmetic_app/constants/models/model_constants.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' show User;

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/preferences/preferences.dart';

/// Clase que gestiona un estado global para la autenticación
class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = "";
  String _role = Preferences.getItem<String>("role") ?? "";
  Bill _selectedBill = billConstant;
  UserApp _userApp = UserApp.copy(userAppConstant);

  final AuthFirebase _authFirebase = AuthFirebase();
  final UsersFirestore _userFirebase = UsersFirestore();

  bool get isLoading => _isLoading;

  String get message => _message;

  set message(String newMessage) {
    _message = newMessage;

    notifyListeners();
  }

  String get role => _role;

  Bill get selectedBill => _selectedBill;

  set selectedBill(Bill newSelectedBill) {
    _selectedBill = newSelectedBill;

    notifyListeners();
  }

  UserApp get userApp => _userApp;

  set userApp(UserApp newUser) {
    _userApp = newUser;

    notifyListeners();
  }

  /// Elimina un usuario
  Future<bool> deleteUser() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<void> response = await _authFirebase.firebaseDeleteUser(userApp.data.email, userApp.data.password);

    if (!response.isSuccess && response.message.startsWith("Error")) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return false;
    }

    response = await _userFirebase.firebaseDeleteUser(role, userApp);

    if (!response.isSuccess && response.message.startsWith("Error")) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return false;
    }

    _message = "";
    _isLoading = false;

    notifyListeners();
    return true;
  }

  /// Un observador que está pendiente ante cambios en la autenticación del usuario
  Stream<User?> onAuthStateChangesListener() => _authFirebase.firebaseOnAuthStateChangesListener();

  /// Obitiene los datos del usuario administrador
  Future<void> getAdmin() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<UserApp> response = await _userFirebase.firebaseGetAdmin();

    if (!response.isSuccess && response.message.startsWith("Error") && response.data == null) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    if (response.data != null) _userApp = response.data!;

    _message = "";
    _isLoading = false;

    notifyListeners();
  }

  /// Obitne los datos del usuario cliente
  Future<void> getCustomer() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<UserApp> response = await _userFirebase.firebaseGetCustomer();

    if (!response.isSuccess && response.message.startsWith("Error") && response.data == null) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    if (response.data != null) _userApp = response.data!;

    _message = "";
    _isLoading = false;

    notifyListeners();
  }

  /// Inicia sesión de un usuario
  Future<void> signInUser(UserAuth userAuth) async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<void> signInResponse = await _authFirebase.firebaseSignInUser(userAuth);

    if (!signInResponse.isSuccess) {
      await Preferences.setItem<bool>("isAuthenticated", false);

      _message = signInResponse.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    final User? user = _authFirebase.firebaseGetCurrentUser();

    final String uid = user!.uid;

    await Preferences.setItem<String>("uid", uid);

    ApiResponse<UserApp> userResponse = await UsersFirestore().firebaseGetCustomer();

    if (!userResponse.isSuccess && userResponse.message == "$errorMessage$dataNotFoundErorr" && userResponse.data == null) userResponse = await UsersFirestore().firebaseGetAdmin();

    await Preferences.setItem<bool>("isAuthenticated", true);

    if (userResponse.data != null) await Preferences.setItem<String>("role", userApp.data.role);

    if (userResponse.data != null) _userApp = userResponse.data!;

    _role = userApp.data.role;
    _message = "";
    _isLoading = false;

    notifyListeners();
  }

  /// Cierra la sesión de un usuario
  void signOutUser() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<void> response = await _authFirebase.firebaseSignOutUser();

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    Preferences.removeItem("isAuthenticated");
    Preferences.removeItem("role");
    Preferences.removeItem("uid");

    _message = "";
    _userApp = userAppConstant;
    _isLoading = false;

    notifyListeners();
  }

  /// Registra un usuario
  Future<void> signUpUser(UserAuth userAuth) async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<void> response = await _authFirebase.firebaseSignUpUser(UserAuth(
      email: userAuth.email,
      password: userAuth.password,
    ));

    if (!response.isSuccess) {
      await Preferences.setItem<bool>("isAuthenticated", false);

      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    final User? user = _authFirebase.firebaseGetCurrentUser();

    user == null ? Preferences.removeItem("uid") : await Preferences.setItem<String>("uid", user.uid);

    await Preferences.setItem<String>("role", "customer");

    await Preferences.setItem<bool>("isAuthenticated", true);

    _role = "customer";
    _message = "";
    _isLoading = false;

    notifyListeners();
  }

  /// Actualiza los datos de un usuario
  Future<void> updateUser(UserApp user) async {
    ApiResponse<void> response;

    _isLoading = true;

    notifyListeners();

    response = await _authFirebase.firebaseUpdateEmail(userApp, user.data.email);

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    response = await _authFirebase.firebaseUpdatePassword(userApp, user.data.password);

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    response = await _userFirebase.firebaseUpdateUser(user);

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    _message = response.message;
    _userApp = UserApp.copy(user);
    _isLoading = false;

    notifyListeners();
  }

  /// Deselecciona una factura
  void unselectBill() {
    _selectedBill = billConstant;

    notifyListeners();
  }
}
