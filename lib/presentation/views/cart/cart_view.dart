import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/presentation/widgets/cart/index.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/constants/design/design_constants.dart';
import 'package:cosmetic_app/constants/images/image_constants.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final AuthProvider authProvider = context.watch<AuthProvider>();
    final CartProvider cartProvider = context.watch<CartProvider>();
    final ViewProvider viewProvider = context.watch<ViewProvider>();

    if (cartProvider.message.isNotEmpty) {
      Future.microtask(
        () => showDialogWidget<void>(
          context,
          cartProvider.message.split("/")[0],
          cartProvider.message.split("/")[1],
          () {
            Navigator.of(context).pop();

            cartProvider.message = "";

            viewProvider.currentIndex = 0;
          },
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverAppBarWidget(
                image: cartAppBar,
                title: "Carrito",
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  cartProvider.cartItems.isEmpty
                      ? [
                          EmptyCartListWidget(
                            buttonPressed: () => viewProvider.currentIndex = 0,
                            buttonText: "Nuestros productos",
                            icon: Icons.sentiment_dissatisfied_outlined,
                            title: "¡Qué mal!",
                            text: "No has agreado productos a tu carrito, te propongo ver nuestro catálogo",
                          )
                        ]
                      : cartProvider.cartItems
                          .map((CartItem cartItem) => CartItemWidget(
                                cartItem: cartItem,
                              ))
                          .toList(),
                ),
              ),
            ],
          ),
        ),
        if (cartProvider.cartItems.isNotEmpty)
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 50.0,
            width: double.infinity,
            child: cartProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5.0,
                      backgroundColor: colorScheme.inverseSurface,
                      foregroundColor: colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRdaius),
                      ),
                    ),
                    onPressed: cartProvider.isLoading
                        ? null
                        : () async {
                            await cartProvider.addBillToUser();

                            authProvider.role == "admin" ? await authProvider.getAdmin() : await authProvider.getCustomer();
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Comprar:",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          "\$${(cartProvider.total).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 25.0,
                            decoration: TextDecoration.underline,
                            decorationColor: colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
      ],
    );
  }
}
