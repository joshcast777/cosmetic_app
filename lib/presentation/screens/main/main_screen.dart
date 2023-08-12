import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/views/cart/index.dart';
import 'package:cosmetic_app/presentation/views/products/index.dart';
import 'package:cosmetic_app/presentation/views/profile/index.dart';
import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> screens = [
    const ProductsView(),
    const CartView(),
    const ProfileView(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewProvider viewProvider = context.watch<ViewProvider>();

    return Scaffold(
      body: IndexedStack(
        index: viewProvider.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: viewProvider.currentIndex,
        onTap: (int newIndex) => viewProvider.currentIndex = newIndex,
      ),
    );
  }
}
