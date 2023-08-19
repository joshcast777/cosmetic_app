import 'package:cosmetic_app/constants/errors/error_constants.dart';
import 'package:cosmetic_app/constants/models/model_constants.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' show User;

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/preferences/preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = "";
  String _role = "";
  Bill _selectedBill = billConstant;
  UserApp _userApp = userAppConstant;

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

    response = await _userFirebase.firebaseDeleteUser();

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

  Stream<User?> onAuthStateChangesListener() => _authFirebase.firebaseOnAuthStateChangesListener();

  Future<void> getAdmin() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<UserApp> response = await _userFirebase.firebaseGetAdmin();

    if (!response.isSuccess && response.message.startsWith("Error")) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    _userApp = response.data!;

    _message = "";
    _isLoading = false;

    notifyListeners();
  }

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

    _userApp = response.data!;

    _message = "";
    _isLoading = false;

    notifyListeners();
  }

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

    final UserApp userAppResponse = userResponse.data!;

    if (userResponse.data != null) await Preferences.setItem<String>("role", userApp.data.role);

    _role = userApp.data.role;
    _userApp = userAppResponse;
    _message = "";
    _isLoading = false;

    notifyListeners();
  }

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

  void signUpUser(UserAuth userAuth) async {
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

  Future<void> updateUser(UserApp user) async {
    ApiResponse<void> response;

    _isLoading = true;

    notifyListeners();

    if (user.data.email != userApp.data.email) {
      response = await _authFirebase.firebaseUpdateEmail(userApp, user.data.email);

      if (!response.isSuccess) {
        _message = response.message;
        _isLoading = false;

        notifyListeners();
        return;
      }
    }

    if (user.data.password != userApp.data.password) {
      response = await _authFirebase.firebaseUpdatePassword(userApp, user.data.password);

      if (!response.isSuccess) {
        _message = response.message;
        _isLoading = false;

        notifyListeners();
        return;
      }
    }

    response = await _userFirebase.firebaseUpdateUser(user);

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    _message = response.message;
    _isLoading = false;

    notifyListeners();
  }

  void unselectBill() {
    _selectedBill = billConstant;

    notifyListeners();
  }
}
