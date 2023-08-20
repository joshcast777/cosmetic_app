import 'package:cosmetic_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/constants/success/success_constants.dart';
import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:cosmetic_app/presentation/views/products/index.dart';
import 'package:cosmetic_app/presentation/widgets/shared/index.dart';
import 'package:cosmetic_app/utils/index.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _showDialog = false;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    final CartProvider cartProvider = context.watch<CartProvider>();
    final ProductProvider productProvider = context.watch<ProductProvider>();
    final ViewProvider viewProvider = context.read<ViewProvider>();

    Product selectedProduct = productProvider.selectedProduct;

    final String role = authProvider.role;

    if (productProvider.message.isNotEmpty && !productProvider.isLoading && _showDialog) {
      Future.microtask(
        () => showDialogWidget<void>(
          context,
          productProvider.message.split("/")[0],
          productProvider.message.split("/")[1],
          () {
            if (productProvider.message.startsWith(successMessage)) {
              productProvider.unselectProduct();

              productProvider.message = "";
              productProvider.getProducts();

              viewProvider.currentIndex = 0;

              setState(() => _showDialog = false);

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(selectedProduct.data.name),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                productProvider.unselectProduct();

                Navigator.of(context).pop();
              },
            ),
          ),
          body: const ProductView(),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (role == "admin") {
                    Navigator.pushNamed(context, AppRoutes.productFormRoute);
                  } else {
                    if (!cartProvider.cartItems.any((CartItem cartItem) => cartItem.product == selectedProduct)) {
                      cartProvider.addToCart(selectedProduct);

                      showSnackBar(context, "Agregado al carrito", "Deshacer", snackBarActionOnPressed: () => cartProvider.removeProductFromCart(selectedProduct));
                    } else {
                      cartProvider.removeProductFromCart(selectedProduct);

                      showSnackBar(context, "Eliminado del carrito", "Deshacer", snackBarActionOnPressed: () => cartProvider.addToCart(selectedProduct));
                    }
                  }
                },
                child: role == "admin"
                    ? const Icon(Icons.edit)
                    : cartProvider.cartItems.any((CartItem cartItem) => cartItem.product == selectedProduct)
                        ? const Icon(Icons.delete)
                        : const Icon(Icons.add_shopping_cart_rounded),
              ),
            ],
          ),
        ),
        if (productProvider.isLoading)
          Container(
            color: Colors.black.withOpacity(0.75),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
