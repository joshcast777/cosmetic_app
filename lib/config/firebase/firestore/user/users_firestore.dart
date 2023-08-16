import 'package:cloud_firestore/cloud_firestore.dart';

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
        message: "$errorMessage$dataNotFoundEror",
      );
    } catch (e) {
      return errorMessageRequest<UserApp>(e);
    }
  }

  Future<ApiResponse<UserApp>> firebaseGetCustomer() async {
    final String uid = Preferences.getItem<String>("uid")!;

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
        List<QueryDocumentSnapshot<Map<String, dynamic>>> collectionDocs = userCollectionsSnapshot.docs;

        List<Bill> bills = [];

        for (QueryDocumentSnapshot<Map<String, dynamic>> collectionDoc in collectionDocs) {
          bills.add(Bill.fromJson({
            "id": collectionDoc.id,
            "data": collectionDoc.data(),
          }));
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
        message: "$errorMessage$dataNotFoundEror",
      );
    } catch (e) {
      return errorMessageRequest<UserApp>(e);
    }
  }
}
