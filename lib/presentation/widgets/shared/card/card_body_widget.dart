import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/card/index.dart';

class CardBodyWidget extends StatelessWidget {
  final String _title;
  final MainAxisAlignment? _bodyMainAxisAlignment;
  final Widget? _content;
  final List<Widget>? _footerChildren;
  final double? _footerMarginTop;

  const CardBodyWidget({
    super.key,
    required String title,
    Widget? content,
    List<Widget>? footerChildren,
    MainAxisAlignment? bodyMainAxisAlignment = MainAxisAlignment.start,
    double? footerMarginTop = 0.0,
  })  : _title = title,
        _bodyMainAxisAlignment = bodyMainAxisAlignment,
        _content = content,
        _footerChildren = footerChildren,
        _footerMarginTop = footerMarginTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: _bodyMainAxisAlignment!,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardContentWidget(
            content: _content,
            title: _title,
          ),
          Container(
            margin: EdgeInsets.only(
              top: _footerMarginTop!,
            ),
            child: CardFooterWidget(
              footerChildren: _footerChildren,
            ),
          ),
        ],
      ),
    );
  }
}
