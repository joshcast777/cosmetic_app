import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/card/index.dart';

class CardBodyWidget extends StatelessWidget {
  final MainAxisAlignment bodyMainAxisAlignment;
  final String title;
  final double footerMarginTop;
  final Widget? content;
  final Widget? firstFooterElement;
  final Widget? secondFooterElement;
  final Widget? thirdFooterElement;

  const CardBodyWidget({
    super.key,
    required this.title,
    this.bodyMainAxisAlignment = MainAxisAlignment.start,
    this.content,
    this.firstFooterElement,
    this.footerMarginTop = 0.0,
    this.secondFooterElement,
    this.thirdFooterElement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: bodyMainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardContentWidget(
            content: content,
            title: title,
          ),
          Container(
            margin: EdgeInsets.only(
              top: footerMarginTop,
            ),
            child: CardFooterWidget(
              firstFooterElement: firstFooterElement,
              secondFooterElement: secondFooterElement,
              thirdFooterElement: thirdFooterElement,
            ),
          ),
        ],
      ),
    );
  }
}
