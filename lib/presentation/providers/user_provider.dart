import 'package:flutter/material.dart';

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/preferences/preferences.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = "";

  final UsersFirestore _userFirebase = UsersFirestore();

  bool get isLoading => _isLoading;

  String get message => _message;

  void addUser(UserAppData userAppData) async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<void> response = await _userFirebase.firebaseAddUser(UserApp(
      id: Preferences.getItem<String>("uid")!,
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
}
