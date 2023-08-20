import 'package:cosmetic_app/constants/design/design_constants.dart';
import 'package:cosmetic_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/presentation/widgets/profile/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late BuildContext _widgetContext;

  @override
  void initState() {
    super.initState();

    _widgetContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final AuthProvider authProvider = Provider.of<AuthProvider>(_widgetContext, listen: false);

      final UserApp userApp = authProvider.userApp;

      if (userApp.id == "") {
          await authProvider.getCustomer();

          if (userApp.id == "") await authProvider.getAdmin();
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    final CartProvider cartProvider = context.watch<CartProvider>();
    final ProductProvider productProvider = context.watch<ProductProvider>();
    final UserProvider userProvider = context.watch<UserProvider>();
    final ViewProvider viewProvider = context.watch<ViewProvider>();

    final UserApp userApp = authProvider.userApp;

    return SingleChildScrollView(
      child: authProvider.isLoading
          ? const SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HeaderProfileWidget(),
                  const Divider(),
                  InfoTileWidget(
                    info: userApp.data.dni,
                    leadingIcon: Icons.credit_card,
                  ),
                  const Divider(),
                  InfoTileWidget(
                    info: userApp.data.name,
                    leadingIcon: Icons.person,
                  ),
                  const Divider(),
                  InfoTileWidget(
                    info: userApp.data.lastName,
                    leadingIcon: Icons.person,
                  ),
                  const Divider(),
                  InfoTileWidget(
                    info: userApp.data.email,
                    leadingIcon: Icons.email,
                  ),
                  if (userApp.data.bills != null) const Divider(),
                  if (userApp.data.bills != null) const Divider(),
                  if (userApp.data.bills != null)
                    InfoTileWidget(
                      info: "Compras realizadas",
                      leadingIcon: Icons.shopping_bag,
                      trailingWidget: IconButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.billsRoute),
                        icon: const Icon(
                          Icons.chevron_right_rounded,
                          size: 30.0,
                        ),
                      ),
                    ),
                  const Divider(),
                  const Divider(),
                  InfoTileWidget(
                    info: "Eliminar cuenta",
                    leadingIcon: Icons.delete_forever,
                    trailingWidget: FilledButton(
                      onPressed: () async {
                        final bool response = await authProvider.deleteUser();

                        if (response) () => _signOut(authProvider, cartProvider, productProvider, userProvider, viewProvider);
                      },
                      child: const Text("Eliminar"),
                    ),
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: FilledButton(
                      onPressed: () => _signOut(authProvider, cartProvider, productProvider, userProvider, viewProvider),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(borderRdaius)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Cerrar sesión".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
    );
  }

  void _signOut(AuthProvider authProvider, CartProvider cartProvider, ProductProvider productProvider, UserProvider userProvider, ViewProvider viewProvider) {
    authProvider.signOutUser();
    cartProvider.clearAll();
    productProvider.clearAll();
    userProvider.clearAll();
    viewProvider.clearAll();
  }
}
