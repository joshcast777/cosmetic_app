import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/images/image_constants.dart';

class CardImageWidget extends StatelessWidget {
  final String _imagePath;
  final double? _imageHeight;
  final double? _imageWidth;

  const CardImageWidget({
    super.key,
    required String imagePath,
    double? imageHeight = double.infinity,
    double? imageWidth = double.infinity,
  })  : _imagePath = imagePath,
        _imageHeight = imageHeight,
        _imageWidth = imageWidth;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      height: _imageHeight,
      width: _imageWidth,
      image: NetworkImage(_imagePath),
      placeholder: const AssetImage(loadingImage),
      fadeInDuration: const Duration(milliseconds: 100),
      fit: BoxFit.cover,
      placeholderFit: BoxFit.cover,
      imageErrorBuilder: (_, __, ___) {
        return Image.asset(
          noImage,
          height: _imageHeight,
          width: _imageWidth,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
