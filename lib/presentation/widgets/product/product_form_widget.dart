import 'dart:io';

import 'package:cosmetic_app/constants/design/design_constants.dart';
import 'package:cosmetic_app/constants/images/image_constants.dart';
import 'package:cosmetic_app/constants/models/model_constants.dart';
import 'package:cosmetic_app/constants/success/success_constants.dart';
import 'package:cosmetic_app/infrastructure/models/index.dart';
import 'package:cosmetic_app/presentation/providers/index.dart';
import 'package:cosmetic_app/presentation/widgets/shared/index.dart';
import 'package:cosmetic_app/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:provider/provider.dart';

class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({super.key});

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  bool _emptySelectedImage = false;
  File? _selectedPicture;
  bool _showDialog = false;

  final ProductData _productData = productDataConstant;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final ProductProvider productProvider = context.watch<ProductProvider>();
    final ViewProvider viewProvider = context.watch<ViewProvider>();

    if (productProvider.message.isNotEmpty && !productProvider.isLoading && _showDialog) {
      Future.microtask(
        () => showDialogWidget(
          context,
          productProvider.message.split("/")[0],
          productProvider.message.split("/")[1],
          () {
            if (productProvider.message.startsWith(successMessage)) {
              productProvider.message = "";
              productProvider.getProducts();

              viewProvider.currentIndex = 0;

              setState(() {
                _selectedPicture = null;
                _formKey.currentState!.reset();
                _showDialog = false;
              });

              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      );
    }

    return Center(
      child: Form(
        key: _formKey,
        child: SizedBox(
          width: 350.0,
          child: Column(
            children: [
              SizedBox(
                height: 200.0,
                width: double.infinity,
                child: _selectedPicture == null
                    ? Image.asset(
                        noImage,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        _selectedPicture!,
                        fit: BoxFit.contain,
                      ),
              ),
              if (_emptySelectedImage)
                SizedBox(
                  child: Center(
                    child: Text(
                      "Imagen requerida",
                      style: TextStyle(
                        color: colorScheme.error,
                      ),
                    ),
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(
                  top: 30.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: const CircleBorder(),
                        side: BorderSide(
                          color: colorScheme.tertiary,
                          width: 2.0,
                        ),
                        foregroundColor: colorScheme.tertiary,
                        disabledForegroundColor: colorScheme.tertiary.withOpacity(0.5),
                        minimumSize: const Size(50.0, 50.0),
                      ),
                      onPressed: () async {
                        final XFile? pickedImage = await selectImage();

                        setState(() => _selectedPicture = File(pickedImage!.path));

                        if (_selectedPicture != null) setState(() => _emptySelectedImage = false);
                      },
                      child: const Icon(Icons.photo_library),
                    ),
                    OutlinedButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: const CircleBorder(),
                        side: BorderSide(
                          color: colorScheme.tertiary,
                          width: 2.0,
                        ),
                        foregroundColor: colorScheme.tertiary,
                        disabledForegroundColor: colorScheme.tertiary.withOpacity(0.5),
                        minimumSize: const Size(50.0, 50.0),
                      ),
                      onPressed: () async {
                        final XFile? pickedImage = await takeImage();

                        setState(() => _selectedPicture = File(pickedImage!.path));

                        if (_selectedPicture != null) setState(() => _emptySelectedImage = false);
                      },
                      child: const Icon(Icons.camera_alt),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FormFieldWidget(
                preffixIcon: Icon(
                  Icons.label,
                  color: colorScheme.primary.withOpacity(0.75),
                  size: 25.0,
                ),
                label: const Text("Nombre"),
                onChanged: (String value) => _productData.name = value,
                validator: (String? value) => fieldValidator(value, errorMessage: "Deben ser 10 dígitos"),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FormFieldWidget(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                preffixIcon: Icon(
                  Icons.attach_money,
                  color: colorScheme.primary.withOpacity(0.75),
                  size: 25.0,
                ),
                label: const Text("Precio"),
                onChanged: (String value) => _productData.price = double.tryParse(value)!,
                validator: (String? value) => fieldValidator(value),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FormFieldWidget(
                maxLines: null,
                preffixIcon: Icon(
                  Icons.short_text,
                  color: colorScheme.primary.withOpacity(0.75),
                  size: 25.0,
                ),
                label: const Text("Resumen"),
                onChanged: (String value) => _productData.summary = value,
                validator: (String? value) => fieldValidator(value!.toUpperCase()),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FormFieldWidget(
                maxLines: null,
                preffixIcon: Icon(
                  Icons.description,
                  color: colorScheme.primary.withOpacity(0.75),
                  size: 25.0,
                ),
                label: const Text("Descripción"),
                onChanged: (String value) => _productData.description = value,
                validator: (String? value) => fieldValidator(value!.toUpperCase()),
              ),
              const SizedBox(
                height: 20.0,
              ),
              productProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: const EdgeInsets.only(
                        top: 30.0,
                      ),
                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState != null && !_formKey.currentState!.validate() && _selectedPicture == null) {
                            setState(() => _emptySelectedImage = true);

                            return;
                          }

                          setState(() => _emptySelectedImage = false);

                          await productProvider.addProduct(_productData, _selectedPicture!);

                          setState(() => _showDialog = true);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(borderRdaius)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Registrar producto".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ),
              if (!productProvider.isLoading)
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedPicture = null;
                        _emptySelectedImage = false;
                        _formKey.currentState!.reset();
                      });

                      viewProvider.currentIndex = 0;
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(borderRdaius)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Cancelar".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
