import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cosmetic_app/constants/database/database_constants.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

class BillsFirestore {
  final FirebaseFirestore _billFirestore = FirebaseFirestore.instance;

  Future<ApiResponse<void>> addBillToUser(String userId, BillData billData) async {
    try {
      DocumentReference userDocument = _billFirestore.collection(customersPathDatabase).doc(userId);

      DocumentReference newBillDocument = userDocument.collection(customerBillPathDatabase).doc();

      await newBillDocument.set({
        'date': Timestamp.fromDate(billData.date),
        'total': billData.total,
        'products': billData.cartItems
            .map((cartItem) => {
                  'amount': cartItem.amount,
                  'product': FirebaseFirestore.instance.collection('products').doc(cartItem.product.id),
                })
            .toList(),
      });

      return ApiResponse<void>(
        isSuccess: true,
        message: "Compra exitosa",
      );
    } catch (error) {
      return ApiResponse<void>(
        isSuccess: false,
        message: "Compra fallida",
      );
    }
  }
}
