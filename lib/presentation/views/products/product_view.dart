import 'package:cosmetic_app/constants/success/success_constants.dart';
import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:cosmetic_app/presentation/widgets/product/index.dart';
import 'package:cosmetic_app/presentation/widgets/shared/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  bool _showDialog = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final AuthProvider authProvider = context.watch<AuthProvider>();
    final ProductProvider productProvider = context.read<ProductProvider>();
    final ViewProvider viewProvider = context.read<ViewProvider>();

    Product selectedProduct = productProvider.selectedProduct;

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
          height: 30.0,
        ),
        if (authProvider.role == "admin")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  shape: const CircleBorder(),
                  minimumSize: const Size(50.0, 50.0),
                ),
                onPressed: () async {
                  await productProvider.deleteProduct();

                  await productProvider.getProducts();

                  setState(() => _showDialog = true);
                },
                child: Icon(
                  Icons.delete_forever,
                  color: colorScheme.onError,
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 100.0,
        ),
      ],
    );
  }
}
