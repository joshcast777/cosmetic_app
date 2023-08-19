import 'package:cosmetic_app/constants/images/image_constants.dart';
import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = context.read<ProductProvider>();

    Product selectedProduct = productProvider.selectedProduct;

    return Center(
      child: Container(
        height: 350.0,
        width: 300.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 10,
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 10,
              blurRadius: 20,
              offset: const Offset(0, 30),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            placeholder: const AssetImage(noImage),
            fit: BoxFit.cover,
            image: NetworkImage(selectedProduct.data.imageUrl),
          ),
        ),
      ),
    );
  }
}
