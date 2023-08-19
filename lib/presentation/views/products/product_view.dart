import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:cosmetic_app/presentation/widgets/product/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = context.read<ProductProvider>();

    Product selectedProduct = productProvider.selectedProduct;

    return ListView(
      children: [
        const SizedBox(
          height: 30.0,
        ),
        const ProductImageWidget(),
        const SizedBox(
          height: 50.0,
        ),
        Center(
          child: Text(
            selectedProduct.data.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Center(
          child: Text(
            "\$${selectedProduct.data.price.toStringAsFixed(2)}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green[600],
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Center(
          child: SizedBox(
            width: 350.0,
            child: Text(
              selectedProduct.data.summary,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Center(
          child: SizedBox(
            width: 350.0,
            child: Text(
              selectedProduct.data.description,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 150.0,
        ),
      ],
    );
  }
}
