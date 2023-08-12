import 'package:flutter/material.dart';

class CardFooterWidget extends StatelessWidget {
  final List<Widget>? _footerChildren;

  const CardFooterWidget({
    super.key,
    List<Widget>? footerChildren = const [],
  }) : _footerChildren = footerChildren;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _footerChildren!,
    );
  }
}
