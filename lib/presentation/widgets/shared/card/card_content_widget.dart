import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/card/index.dart';

class CardContentWidget extends StatelessWidget {
  final String title;
  final Widget? content;

  const CardContentWidget({
    super.key,
    required this.title,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitleWidget(
          title: title,
        ),
        SizedBox(
          child: content,
        ),
      ],
    );
  }
}
