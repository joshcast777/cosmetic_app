import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/utils/index.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final CartProvider cartProvider = context.watch<CartProvider>();

    return CardWidget(
      imagePath: cartItem.product.data.imageUrl,
      title: cartItem.product.data.name,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 5.0,
            ),
            child: Text(
              "Cantidad: ${cartItem.amount}",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 19.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            "\$${(cartItem.product.data.price * cartItem.amount).toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.green[600],
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
      footerChildren: [
        Row(
          children: [
            OutlinedButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: const CircleBorder(),
                side: BorderSide(
                  color: cartItem.amount <= 1 ? colorScheme.tertiary.withOpacity(0.5) : colorScheme.tertiary,
                  width: 2.0,
                ),
                foregroundColor: colorScheme.tertiary,
                disabledForegroundColor: colorScheme.tertiary.withOpacity(0.5),
                minimumSize: const Size(50.0, 50.0),
              ),
              onPressed: cartItem.amount <= 1 ? null : () => cartProvider.decreaseAmount(cartItem),
              child: const Icon(Icons.exposure_minus_1),
            ),
            const SizedBox(
              width: 10.0,
            ),
            OutlinedButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: const CircleBorder(),
                side: BorderSide(
                  color: cartItem.amount >= 10 ? colorScheme.tertiary.withOpacity(0.5) : colorScheme.tertiary,
                  width: 2.0,
                ),
                foregroundColor: colorScheme.tertiary,
                disabledForegroundColor: colorScheme.tertiary.withOpacity(0.5),
                minimumSize: const Size(50.0, 50.0),
              ),
              onPressed: cartItem.amount >= 10 ? null : () => cartProvider.increaseAmount(cartItem),
              child: const Icon(Icons.plus_one),
            ),
          ],
        ),
        FilledButton.tonal(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            shape: const CircleBorder(),
            minimumSize: const Size(50.0, 50.0),
          ),
          onPressed: () {
            cartProvider.removeFromCart(cartItem);

            showSnackBar(context, "Eliminado del carrito", "Deshacer", () => cartProvider.addToCart(cartItem.product));
          },
          child: Icon(
            Icons.delete,
            color: colorScheme.onError,
          ),
        ),
      ],
    );
  }
}
