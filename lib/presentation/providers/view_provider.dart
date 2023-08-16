import 'package:flutter/material.dart';

class ViewProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int newIndex) {
    _currentIndex = newIndex;

    notifyListeners();
  }

  void showSnackBarWidget(BuildContext context, String snackBarText, String snackBarActionLabel, VoidCallback snackBarActionOnPressed, int durationInSeconds, VoidCallback closedAction) {
    final ScaffoldMessengerState scaffolMessenger = ScaffoldMessenger.of(context);

    scaffolMessenger
        .showSnackBar(SnackBar(
          content: Text(snackBarText),
          duration: Duration(
            seconds: durationInSeconds,
          ),
          action: SnackBarAction(
            label: snackBarActionLabel,
            onPressed: snackBarActionOnPressed,
          ),
        ))
        .closed
        .then((_) => closedAction());
  }
}
