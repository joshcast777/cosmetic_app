import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/presentation/widgets/profile/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();

    final UserApp userApp = authProvider.userApp;

    if (userApp.id == "") {
      authProvider.getCustomer();

      if (userApp.id == "") authProvider.getAdmin();
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: authProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : authProvider.message.isEmpty
                ? const Center(
                    child: Text("No se pudo obtener el usuario, cierre y vuelva a iniciar sesión"),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const HeaderProfileWidget(),
                      const Divider(),
                      InfoTileWidget(
                        info: userApp.data.dni,
                        icon: Icons.credit_card,
                      ),
                      const Divider(),
                      InfoTileWidget(
                        info: userApp.data.name,
                        icon: Icons.person,
                      ),
                      const Divider(),
                      InfoTileWidget(
                        info: userApp.data.lastName,
                        icon: Icons.person,
                      ),
                      const Divider(),
                      InfoTileWidget(
                        info: userApp.data.email,
                        icon: Icons.email,
                      ),
                      const Divider(),
                      ElevatedButton(
                        onPressed: () {
                          authProvider.signOutUser();
                        },
                        child: const Text("Cerrar sesión"),
                      ),
                    ],
                  ),
      ),
    );
  }
}
