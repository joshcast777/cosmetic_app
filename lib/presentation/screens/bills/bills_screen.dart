import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:cosmetic_app/presentation/widgets/cart/index.dart';
import 'package:cosmetic_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();

    final List<Bill>? bills = authProvider.userApp.data.bills;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Compras"),
      ),
      body: bills!.isEmpty
          ? EmptyCartListWidget(
              buttonPressed: () {},
              buttonText: "Nuestros productos",
              icon: Icons.sentiment_dissatisfied_outlined,
              title: "¡Qué mal!",
              text: "No has realizado compras, te propongo ver nuestro catálogo",
            )
          : ListView.builder(
              itemCount: bills.length,
              itemBuilder: (_, int index) {
                return Column(
                  children: [
                    if (index == 0)
                      const SizedBox(
                        height: 50.0,
                      ),
                    if (index == 0) const Divider(),
                    Container(
                      height: 40.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            bills[index].data.date.toString().split(" ")[0],
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              authProvider.selectedBill = bills[index];

                              Navigator.pushNamed(context, AppRoutes.billRoute);
                            },
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
    );
  }
}
