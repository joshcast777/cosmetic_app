import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/images/image_constants.dart';

class ImageLogoWidget extends StatelessWidget {
  final double? _width;

  const ImageLogoWidget({
    super.key,
    double? width,
  }) : _width = width;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(imageLogo),
      width: _width,
    );
  }
}
