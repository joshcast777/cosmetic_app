import 'package:flutter/material.dart';

Future<T?> showDialogWidget<T>(BuildContext context, String title, String message, VoidCallback onPressedAction) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 75.0,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              message,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => onPressedAction(),
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}
