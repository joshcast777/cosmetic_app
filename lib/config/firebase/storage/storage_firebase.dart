import 'dart:io';

import 'package:cosmetic_app/constants/storage/storage_constant.dart';
import 'package:cosmetic_app/constants/success/success_constants.dart';
import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/utils/error_message_request.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebase {
  final FirebaseStorage storageFirebase = FirebaseStorage.instance;

  Future<ApiResponse<List<String>>> firebaseAddImage(File selectedPicture, String uid) async {
    final Reference productsReference = storageFirebase.ref().child("$storageProductsFolderConstant/$uid.${selectedPicture.path.split(".").last}");

    try {
      final TaskSnapshot snapshot = await productsReference.putFile(selectedPicture);

      final String fullPath = snapshot.ref.fullPath;

      final String url = await snapshot.ref.getDownloadURL();

      return ApiResponse<List<String>>(
        isSuccess: true,
        message: "",
        data: [url, fullPath],
      );
    } catch (e) {
      return errorMessageRequest<List<String>>(e);
    }
  }

  Future<ApiResponse<void>> firebaseDeleteImage(String fullPath) async {
    final Reference reference = storageFirebase.ref().child(fullPath);

    try {
      await reference.delete();

      return ApiResponse<void>(
        isSuccess: true,
        message: "$successMessage$successfullyDeletedStorage",
      );
    } catch (e) {
      return errorMessageRequest<void>(e);
    }
  }
}
