import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetic_app/constants/success/success_constants.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/preferences/preferences.dart';

import 'package:cosmetic_app/utils/index.dart';

import 'package:cosmetic_app/constants/database/database_constants.dart';
import 'package:cosmetic_app/constants/errors/error_constants.dart';

class UsersFirestore {
  final FirebaseFirestore _userFirestore = FirebaseFirestore.instance;

  Future<ApiResponse<void>> firebaseAddUser(UserApp userApp) async {
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance.collection(customersPathDatabase).doc(userApp.id);

    try {
      await documentReference.set(userApp.data.toJson());

      await documentReference.collection(customerBillPathDatabase).doc().set({});

      return ApiResponse<void>(
        isSuccess: true,
        message: "",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }

  Future<ApiResponse<void>> firebaseDeleteUser() async {
    final String role = Preferences.getItem<String>("role")!;
    final String uid = Preferences.getItem<String>("uid")!;

    try {
      await _userFirestore.collection("${role}s").doc(uid).delete();

      return ApiResponse<void>(
        isSuccess: true,
        message: "",
      );
    } catch (e) {
      return errorMessageRequest(e);
    }
  }

  Future<ApiResponse<UserApp>> firebaseGetAdmin() async {
    final String uid = Preferences.getItem<String>("uid")!;

    try {
      final DocumentReference<Map<String, dynamic>> adminReference = _userFirestore.collection(adminsPathDatabase).doc(uid);

      final DocumentSnapshot<Map<String, dynamic>> adminSnapshot = await adminReference.get();

      if (adminSnapshot.exists) {
        Map<String, dynamic> userData = adminSnapshot.data()!;

        UserApp userApp = UserApp.fromJson({
          "id": uid,
          "data": userData,
        });

        return ApiResponse<UserApp>(
          isSuccess: true,
          message: "",
          data: userApp,
        );
      }

      return ApiResponse<UserApp>(
        isSuccess: false,
        message: "$errorMessage$dataNotFoundErorr",
      );
    } catch (e) {
      return errorMessageRequest<UserApp>(e);
    }
  }

  Future<ApiResponse<UserApp>> firebaseGetCustomer() async {
    final String? uid = Preferences.getItem<String>("uid");

    try {
      final DocumentReference<Map<String, dynamic>> customerReference = _userFirestore.collection(customersPathDatabase).doc(uid);

      final DocumentSnapshot<Map<String, dynamic>> customerSnapshot = await customerReference.get();

      if (customerSnapshot.exists) {
        Map<String, dynamic> userData = customerSnapshot.data()!;

        UserApp userApp = UserApp.fromJson({
          "id": uid,
          "data": userData,
        });

        CollectionReference<Map<String, dynamic>> userCollections = customerReference.collection(customerBillPathDatabase);
        QuerySnapshot<Map<String, dynamic>> userCollectionsSnapshot = await userCollections.get();

        List<Bill> bills = [];

        for (QueryDocumentSnapshot<Map<String, dynamic>> collectionDoc in userCollectionsSnapshot.docs) {
          Map<String, dynamic> billData = collectionDoc.data();

          DateTime date = billData['date'].toDate();

          double total = billData['total'] / 1;

          List<Map<String, dynamic>> productsList = (billData['products'] as List<dynamic>).cast<Map<String, dynamic>>();

          List<CartItem> products = [];

          for (Map<String, dynamic> productData in productsList) {
            int amount = productData['amount'] as int;
            DocumentReference<Map<String, dynamic>> productReference = productData['product'];

            DocumentSnapshot<Map<String, dynamic>> productSnapshot = await productReference.get();

            if (productSnapshot.exists) {
              Map<String, dynamic> productData = productSnapshot.data()!;

              Product product = Product(
                id: productSnapshot.id,
                data: ProductData.fromJson(productData),
              );

              products.add(
                CartItem(
                  amount: amount,
                  product: product,
                ),
              );
            }
          }

          bills.add(Bill(
            id: collectionDoc.id,
            data: BillData(
              date: date,
              total: total,
              cartItems: products,
            ),
          ));
        }

        userApp.data.bills = bills;

        return ApiResponse<UserApp>(
          isSuccess: true,
          message: "",
          data: userApp,
        );
      }

      return ApiResponse<UserApp>(
        isSuccess: false,
        message: "$errorMessage$dataNotFoundErorr",
      );
    } catch (e) {
      return errorMessageRequest<UserApp>(e);
    }
  }

  Future<ApiResponse<void>> firebaseUpdateUser(UserApp user) async {
    DocumentReference<Map<String, dynamic>> documentReference = _userFirestore.collection("${Preferences.getItem<String>("role")!}s").doc(user.id);

    try {
      await documentReference.update(user.data.toJson());

      return ApiResponse<void>(
        isSuccess: true,
        message: "$successMessage$successfullySaved",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }
}
