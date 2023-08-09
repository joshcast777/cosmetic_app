import 'package:flutter/material.dart';

import 'package:cosmetic_app/infrastructure/enums/index.dart';

class AuthButtonTabWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final Position position;
  final String text;

  const AuthButtonTabWidget({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    required this.position,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 5.0,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: colorScheme.primary,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(position == Position.left ? 30.0 : 0),
            topLeft: Radius.circular(position == Position.left ? 30.0 : 0),
            bottomRight: Radius.circular(position == Position.left ? 0 : 30.0),
            topRight: Radius.circular(position == Position.left ? 0 : 30.0),
          ),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
