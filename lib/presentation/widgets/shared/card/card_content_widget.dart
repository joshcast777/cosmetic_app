import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/card/index.dart';

class CardContentWidget extends StatelessWidget {
  final String _title;
  final Widget? _content;

  const CardContentWidget({
    super.key,
    required String title,
    Widget? content,
  })  : _title = title,
        _content = content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitleWidget(
          title: _title,
        ),
        SizedBox(
          child: _content,
        ),
      ],
    );
  }
}
