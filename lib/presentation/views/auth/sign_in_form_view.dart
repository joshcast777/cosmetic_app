import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/infrastructure/models/index.dart';

import 'package:cosmetic_app/presentation/widgets/auth/index.dart';
import 'package:cosmetic_app/presentation/widgets/shared/index.dart';

import 'package:cosmetic_app/presentation/providers/index.dart';

import 'package:cosmetic_app/constants/auth/auth_constants.dart';
import 'package:cosmetic_app/constants/regexp/regexp_constants.dart';

import 'package:cosmetic_app/utils/index.dart';

class SignInFormView extends StatefulWidget {
  const SignInFormView({super.key});

  @override
  State<SignInFormView> createState() => _SignInFormViewState();
}

class _SignInFormViewState extends State<SignInFormView> {
  String _message = "";
  bool _obscureText = true;

  UserAuth userAuth = UserAuth(
    email: "",
    password: "",
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final AuthProvider authProvider = context.watch<AuthProvider>();

    if (authProvider.message.isNotEmpty && _message != authProvider.message) {
      Future.microtask(
        () => showSnackBar(
          context,
          authProvider.message.split("/")[1],
          "OK",
          snackBarActionOnPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            authProvider.message = "";
          },
          durationInSeconds: 3,
          closedAction: () => authProvider.message = "",
        ),
      );
    }

    _message = authProvider.message;

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
                  preffixIcon: Icon(
                    Icons.email_outlined,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  label: const Text("Correo electrónico"),
                  onChanged: (String value) => userAuth.email = value,
                  validator: (String? value) => fieldValidator(value, regExp: emailRegExp),
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
                  label: const Text("Contraseña"),
                  onChanged: (String value) => userAuth.password = value,
                  validator: (String? value) => fieldValidator(value, regExp: passwordRegExp),
                ),
                authProvider.isLoading
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SubmitAuthFormButtonWidet(
                        onPressed: () async {
                          if (_formKey.currentState != null && !_formKey.currentState!.validate()) return;

                          await authProvider.signInUser(userAuth);
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
