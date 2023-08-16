import 'package:firebase_core/firebase_core.dart';

import 'package:cosmetic_app/config/firebase/default_firebase_options.dart';

class FirebaseConfig {
  static Future<void> initializeFirebaseApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
