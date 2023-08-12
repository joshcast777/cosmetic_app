import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/utils/index.dart';

class ProductSliverListWidget extends StatelessWidget {
  const ProductSliverListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final CartProvider cartProvider = context.watch<CartProvider>();
    final ProductProvider productProvider = context.watch<ProductProvider>();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          final ProductData productData = productProvider.products[index].data;

          return CardWidget(
            showBadge: cartProvider.cartItems.any((CartItem cartItem) => cartItem.product == productProvider.products[index]),
            badgeMessage: "Agregado",
            imagePath: productData.imageUrl,
            title: productData.name,
            content: Text(productData.summary),
            footerChildren: [
              Text(
                "\$${productData.price.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.green[600],
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      // shape: const CircleBorder(),
                      side: BorderSide(
                        color: colorScheme.tertiary,
                        width: 2.0,
                      ),
                      minimumSize: const Size(50.0, 50.0),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Info",
                      style: TextStyle(
                        color: colorScheme.tertiary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.tertiary,
                      shape: const CircleBorder(),
                      minimumSize: const Size(50.0, 50.0),
                    ),
                    onPressed: cartProvider.cartItems.any((CartItem cartItem) => cartItem.product == productProvider.products[index])
                        ? null
                        : () {
                            final Product product = productProvider.products[index];

                            cartProvider.addToCart(product);

                            showSnackBar(context, "Agregado al carrito", "Deshacer", () => cartProvider.removeProductFromCart(product));
                          },
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: colorScheme.onTertiary,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        childCount: productProvider.products.length,
      ),
    );
  }
}
