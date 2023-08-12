import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/design/design_constants.dart';

class FormFieldInfoButtonWidget extends StatelessWidget {
  final ColorScheme _colors;
  final VoidCallback? _onInfoButtonPressed;

  const FormFieldInfoButtonWidget({
    super.key,
    required ColorScheme colors,
    required void Function()? onInfoButtonPressed,
  })  : _colors = colors,
        _onInfoButtonPressed = onInfoButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5.0,
      ),
      child: IconButton(
        onPressed: _onInfoButtonPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.grey,
          foregroundColor: _colors.onPrimary,
          padding: const EdgeInsets.all(15.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRdaius)),
          ),
        ),
        icon: const Icon(Icons.info_outline_rounded),
      ),
    );
  }
}
