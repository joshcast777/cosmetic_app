import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' show User;

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/preferences/preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = "";
  UserApp _userApp = UserApp(
    id: "",
    data: UserAppData(
      dni: "",
      email: "",
      lastName: "",
      name: "",
      password: "",
      role: "",
      bills: [],
    ),
  );

  final AuthFirebase _authFirebase = AuthFirebase();
  final UsersFirestore _userFirebase = UsersFirestore();

  bool get isLoading => _isLoading;

  String get message => _message;

  UserApp get userApp => _userApp;

  set message(String newMessage) {
    _message = newMessage;

    notifyListeners();
  }

  Stream<User?> onAuthStateChangesListener() => _authFirebase.firebaseOnAuthStateChangesListener();

  void getAdmin() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<UserApp> response = await _userFirebase.firebaseGetAdmin();

    if (!response.isSuccess && response.message.startsWith("Error")) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
    }

    _userApp = response.data!;

    _isLoading = false;
    _message = "";

    notifyListeners();
  }

  void getCustomer() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<UserApp> response = await _userFirebase.firebaseGetCustomer();

    if (!response.isSuccess && response.message.startsWith("Error")) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
    }

    _userApp = response.data!;

    _isLoading = false;
    _message = "";

    notifyListeners();
  }

  void signInUser(UserAuth userAuth) async {
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

    await Preferences.setItem<String>("uid", user!.uid);

    ApiResponse<UserApp> userResponse = await UsersFirestore().firebaseGetCustomer();

    if (!userResponse.isSuccess && userResponse.message == "Error/Data not found") userResponse = await UsersFirestore().firebaseGetAdmin();

    await Preferences.setItem<bool>("isAuthenticated", true);

    await Preferences.setItem<String>("role", userResponse.data!.data.role);

    _userApp = userResponse.data!;
    _message = "";
    _isLoading = false;

    notifyListeners();
  }

  void signOutUser() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<void> response = await _authFirebase.firebaseSignOutUser();

    if (!response.isSuccess) {
      // await Preferences.removeItem("isAuthenticated");

      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    Preferences.removeItem("isAuthenticated");
    Preferences.removeItem("role");
    Preferences.removeItem("uid");

    _message = "";
    _isLoading = false;

    notifyListeners();
    return;
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

    _message = "";
    _isLoading = false;

    notifyListeners();
  }
}
