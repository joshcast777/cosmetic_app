import 'package:flutter/material.dart';

class CardImageWidget extends StatelessWidget {
  final double? imageHeight;
  final double? imageWidth;
  final String imagePath;

  const CardImageWidget({
    super.key,
    required this.imagePath,
    this.imageHeight = double.infinity,
    this.imageWidth = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      height: imageHeight,
      width: imageWidth,
      image: AssetImage(imagePath),
      fit: BoxFit.cover,
    );
  }
}
