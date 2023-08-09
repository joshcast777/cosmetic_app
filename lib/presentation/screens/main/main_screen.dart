import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/views/cart/index.dart';
import 'package:cosmetic_app/presentation/views/products/index.dart';
import 'package:cosmetic_app/presentation/views/profile/index.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const ProductsView(),
    const CartView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: currentIndex,
        onTap: (int newIndex) => setState(() => currentIndex = newIndex),
      ),
    );
  }
}
