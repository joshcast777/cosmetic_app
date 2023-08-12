import 'package:flutter/material.dart';

class ViewProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int newIndex) {
    _currentIndex = newIndex;

    notifyListeners();
  }

  void showSnackBarWidget(BuildContext context, String snackBarText, String snackBarActionLabel, VoidCallback snackBarActionOnPressed) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(snackBarText),
      duration: const Duration(
        seconds: 2,
      ),
      action: SnackBarAction(
        label: snackBarActionLabel,
        onPressed: snackBarActionOnPressed,
      ),
    ));
  }
}
