import 'package:flutter/material.dart';

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = "";
  List<Product> _products = [];

  final ProductsFirestore _productsFirestore = ProductsFirestore();

  bool get isLoading => _isLoading;

  List<Product> get products => _products;

  Future<List<Product>> getProducts() async {
    _isLoading = true;

    ApiResponse<List<Product>> response = await _productsFirestore.firebaseGetProducts();

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return products;
    }

    _products = response.data!;
    _isLoading = false;

    notifyListeners();
    return products;
  }
}
