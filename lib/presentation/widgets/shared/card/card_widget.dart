import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/card/index.dart';

class CardWidget extends StatelessWidget {
  final Widget? content;
  final Widget? firstFooterElement;
  final String imagePath;
  final Widget? secondFooterElement;
  final Widget? thirdFooterElement;
  final String title;

  const CardWidget({
    super.key,
    required this.imagePath,
    required this.title,
    this.content,
    this.firstFooterElement,
    this.secondFooterElement,
    this.thirdFooterElement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => constraints.maxWidth < 500
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CardImageWidget(
                      imageHeight: 200.0,
                      imagePath: imagePath,
                    ),
                    CardBodyWidget(
                      title: title,
                      content: content,
                      firstFooterElement: firstFooterElement,
                      footerMarginTop: 30.0,
                      secondFooterElement: secondFooterElement,
                      thirdFooterElement: thirdFooterElement,
                    ),
                  ],
                )
              : SizedBox(
                  height: 250.0,
                  child: Row(
                    children: [
                      CardImageWidget(
                        imagePath: imagePath,
                        imageWidth: 200.0,
                      ),
                      Expanded(
                        child: CardBodyWidget(
                          bodyMainAxisAlignment: MainAxisAlignment.spaceBetween,
                          title: title,
                          content: content,
                          firstFooterElement: firstFooterElement,
                          secondFooterElement: secondFooterElement,
                          thirdFooterElement: thirdFooterElement,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
