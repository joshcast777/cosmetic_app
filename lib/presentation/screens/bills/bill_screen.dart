import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();

    final Bill bill = authProvider.selectedBill;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Factura"),
        leading: IconButton(
          onPressed: () {
            authProvider.unselectBill();

            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text: "Fecha: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: bill.data.date.toString().split(" ")[0]),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: "\$${bill.data.total.toStringAsFixed(2)}"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Divider(),
            const SizedBox(
              height: 30.0,
            ),
            ...bill.data.cartItems
                .map((cartItem) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            cartItem.amount.toString(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            cartItem.product.data.name,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "\$${cartItem.product.data.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
