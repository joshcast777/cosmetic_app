import 'package:firebase_core/firebase_core.dart';

import 'package:cosmetic_app/config/firebase/default_firebase_options.dart';

/// Clase que gestiona la instancia de Firebase
class FirebaseConfig {

  /// Inicializa Firebase en el proyecto
  static Future<void> initializeFirebaseApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
