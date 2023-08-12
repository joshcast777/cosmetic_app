import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

class EmptyCartListWidget extends StatelessWidget {
  const EmptyCartListWidget({super.key});

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
            Icons.sentiment_dissatisfied_outlined,
            color: colorScheme.inverseSurface,
            size: 250.0,
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Text(
              "¡Qué mal!",
              style: TextStyle(
                color: colorScheme.tertiary,
                fontSize: 40.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            "No has agreado productos a tu carrito, te propongo ver nuestro catálogo",
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
              onPressed: () => viewProvider.currentIndex = 0,
              child: const Text("Nuestros productos"),
            ),
          ),
        ],
      ),
    );
  }
}
