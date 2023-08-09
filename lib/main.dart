import 'package:flutter/material.dart';

import 'package:cosmetic_app/routes/routes.dart';

import 'package:cosmetic_app/constants/routes/routes_constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
      ),
      title: 'Material App',
      initialRoute: authRoute,
      routes: routes,
    );
  }
}
