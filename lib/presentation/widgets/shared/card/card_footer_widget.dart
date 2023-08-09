import 'package:flutter/material.dart';

class CardFooterWidget extends StatelessWidget {
  final Widget? firstFooterElement;
  final Widget? secondFooterElement;
  final Widget? thirdFooterElement;

  const CardFooterWidget({
    super.key,
    this.firstFooterElement,
    this.secondFooterElement,
    this.thirdFooterElement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _footerElements(),
    );
  }

  List<Widget> _footerElements() {
    List<Widget> footerElements = [];

    if (firstFooterElement != null) footerElements.add(firstFooterElement!);

    if (secondFooterElement != null) footerElements.add(secondFooterElement!);

    if (thirdFooterElement != null) footerElements.add(thirdFooterElement!);

    return footerElements;
  }
}
