import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/auth/auth_constants.dart';

import 'package:cosmetic_app/presentation/widgets/auth/index.dart';

import 'package:cosmetic_app/infrastructure/enums/index.dart';

class AuthButtonsTabWidget extends StatelessWidget {
  final VoidCallback _onPressed;
  final bool _showForm;

  const AuthButtonsTabWidget({
    super.key,
    required bool showForm,
    required void Function() onPressed,
  })  : _onPressed = onPressed,
        _showForm = showForm;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AuthButtonTabWidget(
            position: Position.left,
            backgroundColor: _showForm ? Colors.transparent : colorScheme.primary,
            foregroundColor: _showForm ? colorScheme.primary : colorScheme.onPrimary,
            onPressed: _onPressed,
            text: signIn,
          ),
        ),
        Expanded(
          child: AuthButtonTabWidget(
            position: Position.right,
            backgroundColor: !_showForm ? Colors.transparent : colorScheme.primary,
            foregroundColor: !_showForm ? colorScheme.primary : colorScheme.onPrimary,
            onPressed: _onPressed,
            text: signUp,
          ),
        ),
      ],
    );
  }
}
