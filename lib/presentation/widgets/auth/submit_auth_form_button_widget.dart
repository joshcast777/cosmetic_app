import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/design/design_constants.dart';

class SubmitAuthFormButtonWidet extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const SubmitAuthFormButtonWidet({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30.0,
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRdaiusButton)),
          ),
        ),
        child: Center(
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 17.0,
            ),
          ),
        ),
      ),
    );
  }
}
