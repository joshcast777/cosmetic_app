import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/screens/index.dart';

class AppRoutes {
  static const String initialRoute = "/";
  static const String productRoute = "/product";
  static const String productFormRoute = "/product-form";
  static const String profileFormRoute = "/profile-form";
  static const String billsRoute = "/bills";
  static const String billRoute = "/bill";

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      initialRoute: (_) => const HomeScreen(),
      productRoute: (_) => const ProductScreen(),
      productFormRoute: (_) => const ProductEditingFormScreen(),
      profileFormRoute: (_) => const ProfileEditingFormScreen(),
      billsRoute: (_) => const BillsScreen(),
      billRoute: (_) => const BillScreen(),
    };
  }
}
