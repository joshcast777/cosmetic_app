import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/constants/images/image_constants.dart';

import 'package:cosmetic_app/presentation/widgets/product/index.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = context.watch<ProductProvider>();

    if (productProvider.products.isEmpty) {
      productProvider.getProductsByInit();

      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            image: productsAppBar,
            title: "Productos",
          ),
          ProductSliverListWidget(),
        ],
      );
    }
  }
}
