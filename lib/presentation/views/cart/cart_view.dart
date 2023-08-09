import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/constants/images/image_constants.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int amount = 1;

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
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5.0,
                      ),
                      child: Text(
                        "Cantidad: $amount",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 19.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "\$500,00",
                      style: TextStyle(
                        color: Colors.green[600],
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                firstFooterElement: Row(
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
                          Icons.exposure_minus_1,
                          color: colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
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
                          Icons.plus_one,
                          color: colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
                secondFooterElement: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: colorScheme.error,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: colorScheme.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
