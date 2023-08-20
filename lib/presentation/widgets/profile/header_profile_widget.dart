import 'dart:math';

import 'package:cosmetic_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

class HeaderProfileWidget extends StatelessWidget {
  const HeaderProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final AuthProvider authProvider = context.watch<AuthProvider>();

    final String userAppName = authProvider.userApp.data.name.isEmpty ? "" : authProvider.userApp.data.name[0].toUpperCase();

    final String userAppLastName = authProvider.userApp.data.lastName.isEmpty ? "" : authProvider.userApp.data.lastName[0].toUpperCase();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          padding: const EdgeInsets.only(
            top: 75.0,
            bottom: 50.0,
          ),
          margin: const EdgeInsets.only(
            bottom: 50.0,
          ),
          child: CircleAvatar(
            radius: 75.0,
            backgroundColor: _randomColor().withOpacity(0.75),
            child: Text(
              "$userAppName$userAppLastName",
              style: const TextStyle(
                fontSize: 75.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: SafeArea(
            child: FilledButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profileFormRoute),
              child: const Text("Editar"),
            ),
          ),
        ),
      ],
    );
  }

  Color _randomColor() {
    final colors = [
      Colors.blueGrey,
      Colors.cyan,
      Colors.amber,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
    ];

    return colors[Random().nextInt(10)];
  }
}
