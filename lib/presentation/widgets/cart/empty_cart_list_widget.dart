import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

import 'package:cosmetic_app/constants/design/design_constants.dart';

class EmptyCartListWidget extends StatelessWidget {
  final String _buttonText;
  final VoidCallback _buttonPressed;
  final IconData _icon;
  final String _text;
  final String _title;

  const EmptyCartListWidget({
    super.key,
    required VoidCallback buttonPressed,
    String buttonText = "Texto del botón",
    IconData icon = Icons.lens,
    String text = "Escribe tu texto",
    String title = "Tu título",
  })  : _buttonPressed = buttonPressed,
        _buttonText = buttonText,
        _icon = icon,
        _text = text,
        _title = title;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final ViewProvider viewProvider = context.watch<ViewProvider>();

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 25.0,
      ),
      child: Column(
        children: [
          Icon(
            _icon,
            color: colorScheme.inverseSurface,
            size: 250.0,
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Text(
              _title,
              style: TextStyle(
                color: colorScheme.tertiary,
                fontSize: 40.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.inverseSurface,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 25.0,
            ),
            child: FilledButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(13.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRdaius),
                ),
              ),
              onPressed: _buttonPressed,
              child: Text(
                _buttonText,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
