import 'package:flutter/material.dart';

class InfoTileWidget extends StatelessWidget {
  final IconData _icon;
  final String _info;

  const InfoTileWidget({
    super.key,
    required String info,
    required IconData icon,
  })  : _icon = icon,
        _info = info;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            _icon,
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
        ],
      ),
    );
  }
}
