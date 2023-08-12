import 'package:flutter/material.dart';

import 'package:cosmetic_app/presentation/widgets/shared/form/index.dart';

class FormFieldWidget extends StatelessWidget {
  final bool _obscureText;
  final bool _showInfoButton;
  final bool? _enabled;
  final String? _errorMessage;
  final String? _hint;
  final String? _initialValue;
  final TextInputType? _keyboardType;
  final Widget? _label;
  final void Function(String)? _onChanged;
  final VoidCallback? _onInfoButtonPressed;
  final VoidCallback? _onSuffixIconTap;
  final Widget? _preffixIcon;
  final IconData? _suffixIcon;
  final String? Function(String?)? _validator;

  const FormFieldWidget({
    super.key,
    String? errorMessage,
    String? hint,
    String? initialValue,
    TextInputType? keyboardType,
    Widget? label,
    Widget? preffixIcon,
    IconData? suffixIcon,
    void Function()? onInfoButtonPressed,
    void Function()? onSuffixIconTap,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    bool? enabled = true,
    bool obscureText = false,
    bool showInfoButton = false,
  })  : _obscureText = obscureText,
        _showInfoButton = showInfoButton,
        _enabled = enabled,
        _errorMessage = errorMessage,
        _hint = hint,
        _initialValue = initialValue,
        _keyboardType = keyboardType,
        _label = label,
        _onChanged = onChanged,
        _onInfoButtonPressed = onInfoButtonPressed,
        _onSuffixIconTap = onSuffixIconTap,
        _preffixIcon = preffixIcon,
        _suffixIcon = suffixIcon,
        _validator = validator;

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
            enabled: _enabled,
            initialValue: _initialValue,
            keyboardType: _keyboardType,
            obscureText: _obscureText,
            onChanged: _onChanged,
            decoration: InputDecoration(
              label: _label,
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
              errorText: _errorMessage,
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
              hintText: _hint,
              hintStyle: TextStyle(
                color: colorScheme.primary.withOpacity(0.5),
              ),
              prefixIcon: _preffixIcon,
              suffixIcon: _suffixIcon != null
                  ? GestureDetector(
                      onTap: _onSuffixIconTap,
                      child: Icon(
                        _suffixIcon,
                        color: colorScheme.tertiary.withOpacity(0.75),
                      ),
                    )
                  : null,
            ),
            validator: _validator,
          ),
        ),
        if (_showInfoButton)
          FormFieldInfoButtonWidget(
            onInfoButtonPressed: _onInfoButtonPressed,
            colors: colorScheme,
          ),
      ],
    );
  }
}
