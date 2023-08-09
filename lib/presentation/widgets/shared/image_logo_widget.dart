import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/images/image_constants.dart';

class ImageLogoWidget extends StatelessWidget {
  final double? width;

  const ImageLogoWidget({
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(imageLogo),
      width: width,
    );
  }
}
