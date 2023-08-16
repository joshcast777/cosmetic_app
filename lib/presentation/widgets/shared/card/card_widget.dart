import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/constants/design/design_constants.dart';

class CardWidget extends StatelessWidget {
  final String _imagePath;
  final String _title;
  final Widget? _badge;
  final String? _badgeMessage;
  final Widget? _content;
  final List<Widget>? _footerChildren;
  final bool? _showBadge;

  const CardWidget({
    super.key,
    required String imagePath,
    required String title,
    Widget? badge,
    String? badgeMessage,
    Widget? content,
    List<Widget>? footerChildren,
    bool? showBadge = false,
  })  : _imagePath = imagePath,
        _title = title,
        _badge = badge,
        _badgeMessage = badgeMessage,
        _content = content,
        _footerChildren = footerChildren,
        _showBadge = showBadge;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cardRadius),
              side: BorderSide(
                color: colorScheme.tertiary,
                width: 0.5,
              ),
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) => constraints.maxWidth < 500
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CardImageWidget(
                          imageHeight: 200.0,
                          imagePath: _imagePath,
                        ),
                        CardBodyWidget(
                          title: _title,
                          content: _content,
                          footerMarginTop: 30.0,
                          footerChildren: _footerChildren,
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 250.0,
                      child: Row(
                        children: [
                          CardImageWidget(
                            imagePath: _imagePath,
                            imageWidth: 200.0,
                          ),
                          Expanded(
                            child: CardBodyWidget(
                              bodyMainAxisAlignment: MainAxisAlignment.spaceBetween,
                              title: _title,
                              content: _content,
                              footerChildren: _footerChildren,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          _showBadge != null && _showBadge!
              ? Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: _badge ??
                        Text(
                          _badgeMessage != null ? _badgeMessage! : "",
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                        ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
