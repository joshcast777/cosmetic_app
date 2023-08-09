import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/auth/index.dart';

import 'package:cosmetic_app/constants/auth/auth_constants.dart';

import 'package:cosmetic_app/infrastructure/enums/index.dart';

class AuthButtonsTabWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool showForm;

  const AuthButtonsTabWidget({
    super.key,
    required this.showForm,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AuthButtonTabWidget(
            position: Position.left,
            backgroundColor: showForm ? Colors.transparent : colorScheme.primary,
            foregroundColor: showForm ? colorScheme.primary : colorScheme.onPrimary,
            onPressed: onPressed,
            text: signIn,
          ),
        ),
        Expanded(
          child: AuthButtonTabWidget(
            position: Position.right,
            backgroundColor: !showForm ? Colors.transparent : colorScheme.primary,
            foregroundColor: !showForm ? colorScheme.primary : colorScheme.onPrimary,
            onPressed: onPressed,
            text: signUp,
          ),
        ),
      ],
    );
  }
}
