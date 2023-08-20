import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

/// Muestra un SnackBar en la pantalla
void showSnackBar(BuildContext context, String snackBarText, String snackBarActionLabel, {VoidCallback? snackBarActionOnPressed, int durationInSeconds = 2, VoidCallback? closedAction}) {
  final ViewProvider viewProvider = context.read<ViewProvider>();

  viewProvider.showSnackBarWidget(context, snackBarText, snackBarActionLabel, snackBarActionOnPressed ?? () => ScaffoldMessenger.of(context).hideCurrentSnackBar(), durationInSeconds, closedAction ?? () {});
}
