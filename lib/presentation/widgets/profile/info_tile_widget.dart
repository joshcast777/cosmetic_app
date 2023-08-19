import 'package:flutter/material.dart';

class InfoTileWidget extends StatelessWidget {
  final IconData _leadingIcon;
  final String _info;
  final Widget? _trailingWidget;

  const InfoTileWidget({
    super.key,
    required IconData leadingIcon,
    required String info,
    Widget? trailingWidget,
  })  : _leadingIcon = leadingIcon,
        _info = info,
        _trailingWidget = trailingWidget;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 40.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            _leadingIcon,
            size: 35.0,
            color: colorScheme.tertiary,
          ),
          const SizedBox(
            width: 30.0,
          ),
          Text(
            _info,
            style: TextStyle(
              fontSize: 18.0,
              color: colorScheme.onBackground.withOpacity(0.75),
            ),
          ),
          if (_trailingWidget != null) const Spacer(),
          if (_trailingWidget != null) _trailingWidget!,
        ],
      ),
    );
  }
}
