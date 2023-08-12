import 'package:flutter/material.dart';

import 'package:cosmetic_app/infrastructure/enums/index.dart';

class AuthButtonTabWidget extends StatelessWidget {
  final Color _backgroundColor;
  final Color _foregroundColor;
  final VoidCallback _onPressed;
  final Position _position;
  final String _text;

  const AuthButtonTabWidget({
    super.key,
    required Color backgroundColor,
    required Color foregroundColor,
    required void Function() onPressed,
    required Position position,
    required String text,
  })  : _backgroundColor = backgroundColor,
        _foregroundColor = foregroundColor,
        _onPressed = onPressed,
        _position = position,
        _text = text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: _onPressed,
      style: TextButton.styleFrom(
        backgroundColor: _backgroundColor,
        foregroundColor: _foregroundColor,
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
            bottomLeft: Radius.circular(_position == Position.left ? 30.0 : 0),
            topLeft: Radius.circular(_position == Position.left ? 30.0 : 0),
            bottomRight: Radius.circular(_position == Position.left ? 0 : 30.0),
            topRight: Radius.circular(_position == Position.left ? 0 : 30.0),
          ),
        ),
      ),
      child: Text(
        _text.toUpperCase(),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
