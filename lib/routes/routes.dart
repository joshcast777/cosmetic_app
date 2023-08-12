import 'package:flutter/widgets.dart';

import "package:cosmetic_app/constants/routes/routes_constants.dart";

import 'package:cosmetic_app/presentation/screens/index.dart';

Map<String, Widget Function(BuildContext)> routes = {
  authRoute: (_) => const AuthScreen(),
  mainRoute: (_) => MainScreen(),
};
