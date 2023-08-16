import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int _currentIndex;
  final void Function(int)? _onTap;

  const BottomNavBarWidget({
    super.key,
    required int currentIndex,
    required void Function(int)? onTap,
  })  : _currentIndex = currentIndex,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      backgroundColor: const Color.fromRGBO(55, 57, 84, 1),
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      onTap: _onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: "Inicio",
          backgroundColor: colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart_outlined),
          activeIcon: const Icon(Icons.shopping_cart),
          label: "Carrito",
          backgroundColor: colorScheme.tertiary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: "Perfil",
          backgroundColor: colorScheme.secondary,
        ),
      ],
    );
  }
}
