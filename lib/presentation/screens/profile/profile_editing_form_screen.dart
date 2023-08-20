import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cosmetic_app/constants/auth/auth_constants.dart';
import 'package:cosmetic_app/constants/regexp/regexp_constants.dart';
import 'package:cosmetic_app/constants/success/success_constants.dart';
import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:cosmetic_app/presentation/widgets/auth/index.dart';
import 'package:cosmetic_app/presentation/widgets/shared/index.dart';
import 'package:cosmetic_app/utils/index.dart';

class ProfileEditingFormScreen extends StatefulWidget {
  const ProfileEditingFormScreen({super.key});

  @override
  State<ProfileEditingFormScreen> createState() => _ProfileEditingFormScreenState();
}

class _ProfileEditingFormScreenState extends State<ProfileEditingFormScreen> {
  bool _obscureText = true;
  bool _showDialog = false;
  bool _closeSession = false;
  late UserApp _userApp = UserApp.copy(userAppConstant);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    context.read<AuthProvider>().addListener(() {
      setState(() {
        _userApp = UserApp.copy(context.read<AuthProvider>().userApp);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final AuthProvider authProvider = context.watch<AuthProvider>();
    final ProductProvider productProvider = context.read<ProductProvider>();
    final UserProvider userProvider = context.read<UserProvider>();
    final CartProvider cartProvider = context.read<CartProvider>();
    final ViewProvider viewProvider = context.read<ViewProvider>();

    if (authProvider.message.isNotEmpty && !authProvider.isLoading && _showDialog) {
      Future.microtask(
        () => showDialogWidget(
          context,
          authProvider.message.split("/")[0],
          authProvider.message.split("/")[1],
          () {
            if (authProvider.message.startsWith(successMessage)) {
              authProvider.message = "";

              setState(() => _showDialog = false);

              setState(() => _formKey.currentState!.reset());

              // authProvider.userApp = UserApp.copy(_userApp);
              _userApp = UserApp.copy(userAppConstant);

              if (_closeSession) {
                authProvider.signOutUser();
                cartProvider.clearAll();
                productProvider.clearAll();
                userProvider.clearAll();
                viewProvider.clearAll();
              }

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar usuario"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                const SafeArea(
                  child: SizedBox(
                    height: 50.0,
                  ),
                ),
                const Text(
                  "Editar usuario",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SafeArea(
                  child: SizedBox(
                    height: 50.0,
                  ),
                ),
                FormFieldWidget(
                  initialValue: _userApp.data.dni,
                  keyboardType: TextInputType.number,
                  preffixIcon: Icon(
                    Icons.credit_card,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  label: const Text("Cédula"),
                  onChanged: (String value) => _userApp.data.dni = value,
                  validator: (String? value) => fieldValidator(value, regExp: dniRegExp, errorMessage: "Deben ser 10 dígitos"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormFieldWidget(
                  initialValue: _userApp.data.name,
                  preffixIcon: Icon(
                    Icons.person,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  label: const Text("Nombre"),
                  onChanged: (String value) => _userApp.data.name = value,
                  validator: (String? value) => fieldValidator(value!.toUpperCase(), regExp: textRegExp),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormFieldWidget(
                  initialValue: _userApp.data.lastName,
                  preffixIcon: Icon(
                    Icons.person,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  label: const Text("Apellido"),
                  onChanged: (String value) => _userApp.data.lastName = value,
                  validator: (String? value) => fieldValidator(value!.toUpperCase(), regExp: textRegExp),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormFieldWidget(
                  initialValue: _userApp.data.email,
                  keyboardType: TextInputType.emailAddress,
                  preffixIcon: Icon(
                    Icons.email_outlined,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  label: const Text("Correo electrónico"),
                  onChanged: (String value) => _userApp.data.email = value,
                  validator: (String? value) => fieldValidator(value, regExp: emailRegExp),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormFieldWidget(
                  initialValue: _userApp.data.password,
                  obscureText: _obscureText,
                  preffixIcon: Icon(
                    Icons.key_outlined,
                    color: colorScheme.primary.withOpacity(0.75),
                    size: 25.0,
                  ),
                  onSuffixIconTap: () => setState(() => _obscureText = !_obscureText),
                  suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
                  label: const Text("Contraseña"),
                  showInfoButton: true,
                  onInfoButtonPressed: () => _showAlertDialog(context),
                  onChanged: (String value) => _userApp.data.password = value,
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

                          await authProvider.updateUser(_userApp);

                          if (_userApp.data.email != authProvider.userApp.data.email || _userApp.data.password != authProvider.userApp.data.password) setState(() => _closeSession = true);

                          setState(() => _showDialog = true);
                        },
                        label: "Actualizar".toUpperCase(),
                      ),
              ],
            ),
          ),
        ),
      ),
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
