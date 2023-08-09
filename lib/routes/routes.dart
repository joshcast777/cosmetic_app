import "package:flutter/material.dart";

import 'package:cosmetic_app/presentation/screens/index.dart';

import "package:cosmetic_app/constants/routes/routes_constants.dart";

Map<String, Widget Function(BuildContext)> routes = {
  authRoute: (_) => const AuthScreen(),
};
