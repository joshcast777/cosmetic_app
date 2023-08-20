import 'package:flutter/material.dart';

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/preferences/preferences.dart';

/// Clase que gestiona un estado global para el usuario
class UserProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = "";

  final UsersFirestore _userFirebase = UsersFirestore();

  bool get isLoading => _isLoading;

  String get message => _message;

  /// Agrega un usuario
  Future<void> addUser(UserAppData userAppData) async {
    _isLoading = true;

    notifyListeners();

    final String? uid = Preferences.getItem<String>("uid");

    if (uid == null) return;

    ApiResponse<void> response = await _userFirebase.firebaseAddUser(UserApp(
      id: uid,
      data: userAppData,
    ));

    if (response.message.isNotEmpty && response.message.startsWith("Error")) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    _message = "";
    _isLoading = false;

    notifyListeners();
  }

  /// Limpia todo el estado global
  void clearAll() {
    _isLoading = false;
    _message = "";

    notifyListeners();
  }
}
