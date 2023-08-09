import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/constants/images/image_constants.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        const SliverAppBarWidget(
          image: productsAppBar,
          title: "Productos",
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              CardWidget(
                imagePath: productImage,
                title: "Nombre producto",
                content: const Text("Consectetur nisi esse sint commodo dolor irure eu anim. In qui cillum ut qui. Et anim labore sit ipsum incididunt Lorem."),
                firstFooterElement: Text(
                  "\$500,00",
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                secondFooterElement: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: colorScheme.tertiary,
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.info,
                          color: colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: colorScheme.tertiary,
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: colorScheme.onTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
