import 'package:flutter/material.dart';

import 'package:cosmetic_app/constants/routes/routes_constants.dart';

import 'package:cosmetic_app/presentation/widgets/shared/index.dart';
import 'package:cosmetic_app/presentation/widgets/auth/index.dart';

import 'package:cosmetic_app/constants/auth/auth_constants.dart';
import 'package:cosmetic_app/constants/regexp/regexp_constants.dart';

import 'package:cosmetic_app/utils/index.dart';

class SignInFormView extends StatefulWidget {
  const SignInFormView({super.key});

  @override
  State<SignInFormView> createState() => _SignInFormViewState();
}

class _SignInFormViewState extends State<SignInFormView> {
  String email = "";
  String password = "";

  bool _obscureText = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: const Center(
            child: Text(
              "Inicio de sesión",
              style: TextStyle(
                fontSize: 38.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  // preffixIcon: Icons.email_outlined,
                  preffixIcon: Icon(
                    Icons.email_outlined,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  hint: "Ingresa tu correo electrónico",
                  // label: "Correo electrónico",
                  label: const Text("Correo electrónico"),
                  onChanged: (String value) => email = value,
                  validator: (String? value) => fieldValidator(value, emailRegExp),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormFieldWidget(
                  obscureText: _obscureText,
                  preffixIcon: Icon(
                    Icons.key_outlined,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  onSuffixIconTap: () => setState(() => _obscureText = !_obscureText),
                  suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
                  hint: "Ingresa tu contraseña",
                  label: const Text("Contraseña"),
                  onChanged: (String value) => password = value,
                  validator: (String? value) => fieldValidator(value, passwordRegExp),
                ),
                SubmitAuthFormButtonWidet(
                  onPressed: () {
                    if (_formKey.currentState != null && !_formKey.currentState!.validate()) return;

                    Navigator.pushReplacementNamed(context, mainRoute);
                  },
                  label: signIn,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
