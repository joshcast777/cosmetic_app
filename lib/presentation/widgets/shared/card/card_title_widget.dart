import 'package:flutter/material.dart';

class CardTitleWidget extends StatelessWidget {
  final String _title;
  final double? _fontSize;
  final FontWeight? _fontWeight;

  const CardTitleWidget({
    super.key,
    required String title,
    double? fontSize = 25.0,
    FontWeight? fontWeight = FontWeight.w500,
  })  : _title = title,
        _fontSize = fontSize,
        _fontWeight = fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Text(
        _title,
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: _fontWeight,
        ),
      ),
    );
  }
}
