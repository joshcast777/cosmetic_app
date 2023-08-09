import 'package:flutter/material.dart';

class CardTitleWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CardTitleWidget({
    super.key,
    required this.title,
    this.fontSize = 25.0,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
