import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/design/design_constants.dart';

class FormFieldInfoButtonWidget extends StatelessWidget {
  final VoidCallback? onInfoButtonPressed;
  final ColorScheme colors;

  const FormFieldInfoButtonWidget({
    super.key,
    required this.onInfoButtonPressed,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5.0,
      ),
      child: IconButton(
        onPressed: onInfoButtonPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.grey,
          foregroundColor: colors.onPrimary,
          padding: const EdgeInsets.all(15.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRdaiusButton)),
          ),
        ),
        icon: const Icon(Icons.info_outline_rounded),
      ),
    );
  }
}
