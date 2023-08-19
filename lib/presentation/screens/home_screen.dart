import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:cosmetic_app/presentation/screens/index.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();

    return StreamBuilder<User?>(
      stream: authProvider.onAuthStateChangesListener(),
      builder: (_, AsyncSnapshot<User?> snapshot) => snapshot.hasData ? const MainScreen() : const AuthScreen(),
    );
  }
}
