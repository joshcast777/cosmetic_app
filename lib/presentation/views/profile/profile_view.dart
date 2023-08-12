import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/design/design_constants.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool enabledFormField = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 80.0,
                bottom: 40.0,
              ),
              child: const Text(
                "Miguel Castillo",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const CircleAvatar(
              radius: 65.0,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              height: 75.0,
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    "Miguel Castillo",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: colorScheme.onBackground.withOpacity(0.75),
                    ),
                  ),
                ),
                leading: Icon(
                  Icons.person,
                  size: 35.0,
                  color: colorScheme.tertiary,
                ),
              ),
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(
                top: 50.0,
              ),
              // height: 40.0,
              width: 250.0,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(13.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRdaius),
                  ),
                ),
                onPressed: () => setState(() => enabledFormField = !enabledFormField),
                child: const Text(
                  "Editar",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
