import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/config/firebase/index.dart';

import 'package:cosmetic_app/constants/routes/routes_constants.dart';

import 'package:cosmetic_app/routes/routes.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebaseApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.pink,
        ),
        title: 'Material App',
        // initialRoute: authProvider.isAuthenticated ? mainRoute : authRoute,
        initialRoute: mainRoute,
        routes: routes,
      ),
    );
  }
}
