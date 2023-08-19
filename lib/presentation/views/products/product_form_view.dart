import 'package:cosmetic_app/constants/images/image_constants.dart';
import 'package:cosmetic_app/presentation/widgets/product/index.dart';
import 'package:cosmetic_app/presentation/widgets/shared/index.dart';
import 'package:flutter/material.dart';

class ProductFormView extends StatelessWidget {
  const ProductFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBarWidget(
          image: newProductAppBar,
          title: "Nuevo producto",
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(
                height: 75.0,
              ),
              const ProductFormWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
