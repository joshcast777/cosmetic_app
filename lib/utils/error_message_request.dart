import 'package:firebase_auth/firebase_auth.dart' show FirebaseException;

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/constants/errors/error_constants.dart';

/// Devuelve uns respuesta de error de una petición en caso de fallar
ApiResponse<T> errorMessageRequest<T>(Object e) {
  return ApiResponse<T>(
    isSuccess: false,
    message: e is FirebaseException ? "$errorMessage${e.message}" : "$errorMessage$unknownError",
  );
}
