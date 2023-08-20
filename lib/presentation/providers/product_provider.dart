import 'dart:io';

import 'package:cosmetic_app/constants/models/model_constants.dart';
import 'package:flutter/material.dart';

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _message = "";
  List<Product> _products = productsConstant;
  Product _selectedProduct = productConstant;

  final ProductsFirestore _productsFirestore = ProductsFirestore();
  final StorageFirebase _storageFirebase = StorageFirebase();

  bool get isLoading => _isLoading;

  String get message => _message;

  set message(String newMessage) {
    _message = newMessage;

    notifyListeners();
  }

  List<Product> get products => _products;

  Product get selectedProduct => _selectedProduct;

  set selectedProduct(Product newSelectedProduct) {
    _selectedProduct = newSelectedProduct;

    notifyListeners();
  }

  Future<void> addProduct(ProductData productData, File selectedPicture) async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<String> productResponse = await _productsFirestore.firebaseAddProduct(productData);

    if (!productResponse.isSuccess) {
      _message = productResponse.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    ApiResponse<List<String>> imageResponse = await _storageFirebase.firebaseAddImage(selectedPicture, productResponse.data!);

    if (!imageResponse.isSuccess) {
      _message = imageResponse.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    productData.imageUrl = imageResponse.data![0];
    productData.fullPath = imageResponse.data![1];

    ApiResponse<void> responseUpdated = await _productsFirestore.firebaseUpdateProduct(Product(
      id: productResponse.data!,
      data: productData,
    ));

    if (!responseUpdated.isSuccess) {
      _message = responseUpdated.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    _message = responseUpdated.message;
    _isLoading = false;

    notifyListeners();
  }

  void clearAll() {
    _isLoading = false;
    _message = "";
    _products = productsConstant;
    _selectedProduct = productConstant;
  }

  void clearProducts() {
    _products = [];

    notifyListeners();
  }

  Future<void> deleteProduct() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<void> response = await _productsFirestore.firebaseDeleteProduct(selectedProduct.id);

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    response = await _storageFirebase.firebaseDeleteImage(selectedProduct.data.fullPath);

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    _message = response.message;
    _isLoading = false;

    notifyListeners();
  }

  Future<void> getProductsByInit() async {
    _isLoading = true;

    ApiResponse<List<Product>> response = await _productsFirestore.firebaseGetProducts();

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    if (response.data != null) _products = response.data!;
    _isLoading = false;

    notifyListeners();
    return;
  }

  Future<void> getProducts() async {
    _isLoading = true;

    notifyListeners();

    ApiResponse<List<Product>> response = await _productsFirestore.firebaseGetProducts();

    if (!response.isSuccess) {
      _message = response.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    if (response.data != null) _products = response.data!;
    _isLoading = false;

    notifyListeners();
  }

  Future updateProduct(Product product, File? selectedPicture) async {
    _isLoading = true;

    notifyListeners();

    if (selectedPicture != null) {
      ApiResponse<List<String>> imageResponse = await _storageFirebase.firebaseAddImage(selectedPicture, product.id);

      if (!imageResponse.isSuccess) {
        _message = imageResponse.message;
        _isLoading = false;

        notifyListeners();
        return;
      }

      product.data.imageUrl = imageResponse.data![0];
      product.data.fullPath = imageResponse.data![1];
    }

    ApiResponse<void> responseUpdated = await _productsFirestore.firebaseUpdateProduct(product);

    if (!responseUpdated.isSuccess) {
      _message = responseUpdated.message;
      _isLoading = false;

      notifyListeners();
      return;
    }

    _message = responseUpdated.message;
    _selectedProduct = product;
    _isLoading = false;

    notifyListeners();
  }

  void unselectProduct() {
    _selectedProduct = productConstant;

    notifyListeners();
  }
}
