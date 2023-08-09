import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/views/auth/index.dart';

import 'package:cosmetic_app/presentation/widgets/auth/index.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showForm = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: colorScheme.primary.withOpacity(0.15),
                width: 2.0,
              ),
            ),
            constraints: const BoxConstraints(
              maxWidth: 500.0,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: const Center(
                    child: ImageLogoWidget(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: AuthButtonsTabWidget(
                    onPressed: () => setState(() => showForm = !showForm),
                    showForm: showForm,
                  ),
                ),
                showForm ? const SignUpFormView() : const SignInFormView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
