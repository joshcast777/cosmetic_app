import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/form/index.dart';

class FormFieldWidget extends StatelessWidget {
  final String initialValue;
  final bool obscureText;
  final bool showInfoButton;
  final bool? enabled;
  final String? errorMessage;
  final String? hint;
  final TextInputType? keyboardType;
  // final String? label;
  final Widget? label;
  final void Function(String)? onChanged;
  final VoidCallback? onInfoButtonPressed;
  final Widget? preffixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final String? Function(String?)? validator;

  const FormFieldWidget({
    super.key,
    this.errorMessage,
    this.hint,
    this.keyboardType,
    this.label,
    this.onChanged,
    this.onInfoButtonPressed,
    this.onSuffixIconTap,
    this.preffixIcon,
    this.suffixIcon,
    this.validator,
    this.enabled = true,
    this.initialValue = "",
    this.obscureText = false,
    this.showInfoButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: colorScheme.primary.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(5.0),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            enabled: enabled,
            initialValue: initialValue,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              // labelText: label,
              label: label,
              // labelStyle: TextStyle(
              //   color: Colors.blue, // Cambia esto al color que desees
              //   fontSize: 16.0, // Cambia el tamaño de fuente
              //   fontWeight: FontWeight.bold, // Cambia el peso de la fuente
              // ),
              enabledBorder: border,
              disabledBorder: border.copyWith(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusColor: colorScheme.primary,
              focusedBorder: border.copyWith(
                borderSide: BorderSide(
                  color: colorScheme.primary,
                ),
              ),
              errorText: errorMessage,
              errorBorder: border.copyWith(
                borderSide: BorderSide(
                  color: colorScheme.error,
                ),
              ),
              focusedErrorBorder: border.copyWith(
                borderSide: BorderSide(
                  color: colorScheme.error,
                ),
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: colorScheme.primary.withOpacity(0.5),
              ),
              prefixIcon: preffixIcon,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                      onTap: onSuffixIconTap,
                      child: Icon(
                        suffixIcon,
                        color: colorScheme.tertiary.withOpacity(0.75),
                      ),
                    )
                  : null,
              // contentPadding: const EdgeInsets.only(
              //   left: 24.0,
              // ),
            ),
            validator: validator,
          ),
        ),
        if (showInfoButton)
          FormFieldInfoButtonWidget(
            onInfoButtonPressed: onInfoButtonPressed,
            colors: colorScheme,
          ),
      ],
    );
  }
}
