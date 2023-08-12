import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/design/design_constants.dart';

class SubmitAuthFormButtonWidet extends StatelessWidget {
  final String _label;
  final VoidCallback _onPressed;

  const SubmitAuthFormButtonWidet({
    super.key,
    required void Function() onPressed,
    required String label,
  })  : _label = label,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30.0,
      ),
      child: FilledButton(
        onPressed: _onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRdaius)),
          ),
        ),
        child: Center(
          child: Text(
            _label.toUpperCase(),
            style: const TextStyle(
              fontSize: 17.0,
            ),
          ),
        ),
      ),
    );
  }
}
