import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:provider/provider.dart';

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/presentation/screens/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

import 'package:cosmetic_app/preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseConfig.initializeFirebaseApp();

  await Preferences.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider<CartProvider>(
        create: (_) => CartProvider(),
      ),
      ChangeNotifierProvider<ProductProvider>(
        create: (_) => ProductProvider(),
      ),
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider<ViewProvider>(
        create: (_) => ViewProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
      ),
      title: 'Cosmetic App',
      home: StreamBuilder<User?>(
        stream: authProvider.onAuthStateChangesListener(),
        builder: (_, AsyncSnapshot<User?> snapshot) => snapshot.hasData ? MainScreen() : const AuthScreen(),
      ),
    );
  }
}
