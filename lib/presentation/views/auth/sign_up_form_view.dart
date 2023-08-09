import "package:flutter/material.dart";

import "package:cosmetic_app/presentation/widgets/shared/index.dart";
import "package:cosmetic_app/presentation/widgets/auth/index.dart";

import "package:cosmetic_app/constants/routes/routes_constants.dart";

import "package:cosmetic_app/constants/auth/auth_constants.dart";
import "package:cosmetic_app/constants/regexp/regexp_constants.dart";

import "package:cosmetic_app/utils/index.dart";

class SignUpFormView extends StatefulWidget {
  const SignUpFormView({super.key});

  @override
  State<SignUpFormView> createState() => _SignUpFormViewState();
}

class _SignUpFormViewState extends State<SignUpFormView> {
  String dni = "";
  String name = "";
  String lastName = "";
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
              "Registrarse",
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
                  keyboardType: TextInputType.number,
                  preffixIcon: Icon(
                    Icons.credit_card,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  hint: "Ingresa tu cédula",
                  label: const Text("Cédula"),
                  onChanged: (String value) => dni = value,
                  validator: (String? value) => fieldValidator(value, dniRegExp, errorMessage: "Deben ser 10 dígitos"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormFieldWidget(
                  preffixIcon: Icon(
                    Icons.person,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  hint: "Ingresa tu nombre",
                  label: const Text("Nombre"),
                  onChanged: (String value) => name = value,
                  validator: (String? value) => fieldValidator(value!.toUpperCase(), textRegExp),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormFieldWidget(
                  preffixIcon: Icon(
                    Icons.person,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  hint: "Ingresa tu apellido",
                  label: const Text("Apellido"),
                  onChanged: (String value) => lastName = value,
                  validator: (String? value) => fieldValidator(value!.toUpperCase(), textRegExp),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  preffixIcon: Icon(
                    Icons.email_outlined,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  hint: "Ingresa tu correo electrónico",
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
                  showInfoButton: true,
                  onInfoButtonPressed: () => _showAlertDialog(context),
                  onChanged: (String value) => password = value,
                  validator: (String? value) => fieldValidator(value, passwordRegExp),
                ),
                SubmitAuthFormButtonWidet(
                  onPressed: () {
                    if (_formKey.currentState != null && !_formKey.currentState!.validate()) return;

                    Navigator.pushReplacementNamed(context, mainRoute);
                  },
                  label: signUp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _showAlertDialog(BuildContext context) {
    final List<String> conditions = [
      "Al menos una mayúscula",
      "Al menos una minúscula",
      "Al menos un número",
      "Solo caracteres del español",
      "Sin caracteres especiales",
    ];

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Condiciones"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: conditions
                .map(
                  (String condition) => Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 10.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        condition,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}
