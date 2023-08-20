import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetic_app/constants/success/success_constants.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/utils/index.dart';

import 'package:cosmetic_app/constants/database/database_constants.dart';

/// Clase eque gestiona los productos
class ProductsFirestore {
  /// Instancia de la Firebase Firestore
  final FirebaseFirestore _productFirestore = FirebaseFirestore.instance;

  /// Agrega un producto a la Firebase Firestore
  Future<ApiResponse<String>> firebaseAddProduct(ProductData product) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference = _productFirestore.collection(productsPathDatabase).doc();

      await documentReference.set(product.toJson());

      return ApiResponse<String>(
        isSuccess: true,
        message: "$successMessage$successfullySaved",
        data: documentReference.id,
      );
    } catch (e) {
      return errorMessageRequest<String>(e);
    }
  }

  /// Obtiene todos los productos de la Firebase Firestore
  Future<ApiResponse<List<Product>>> firebaseGetProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _productFirestore.collection(productsPathDatabase).get();

      List<Product> products = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
        products.add(Product.fromJson({
          "id": docSnapshot.id,
          "data": docSnapshot.data(),
        }));
      }

      return ApiResponse<List<Product>>(
        isSuccess: true,
        message: "",
        data: products,
      );
    } catch (e) {
      return errorMessageRequest<List<Product>>(e);
    }
  }

  /// Actualiza los datos de un producto de la Firebase Firestore
  Future<ApiResponse<void>> firebaseUpdateProduct(Product product) async {
    DocumentReference<Map<String, dynamic>> documentReference = _productFirestore.collection(productsPathDatabase).doc(product.id);

    try {
      await documentReference.update(product.data.toJson());

      return ApiResponse<void>(
        isSuccess: true,
        message: "$successMessage$successfullySaved",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }

  /// Elimina un producto e la Firebase Firestore
  Future<ApiResponse<void>> firebaseDeleteProduct(String id) async {
    DocumentReference<Map<String, dynamic>> documentReference = _productFirestore.collection(productsPathDatabase).doc(id);

    try {
      await documentReference.delete();

      return ApiResponse<void>(
        isSuccess: true,
        message: "$successMessage$deletedProductConstant",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }
}
