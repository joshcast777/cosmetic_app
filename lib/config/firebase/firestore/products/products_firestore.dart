import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cosmetic_app/constants/database/database_constants.dart';
import 'package:cosmetic_app/constants/errors/error_constants.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

class ProductsFirestore {
  final FirebaseFirestore _productFirestore = FirebaseFirestore.instance;

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
      return ApiResponse<List<Product>>(
        isSuccess: false,
        message: e is FirebaseException ? "$errorMessage${e.message}" : "$errorMessage$unknownError",
      );
    }
  }
}
