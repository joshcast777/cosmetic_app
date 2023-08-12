import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

void showSnackBar(BuildContext context, String snackBarText, String snackBarActionLabel, VoidCallback snackBarActionOnPressed) {
  final ViewProvider viewProvider = context.read<ViewProvider>();

  viewProvider.showSnackBarWidget(context, snackBarText, snackBarActionLabel, snackBarActionOnPressed);
}
