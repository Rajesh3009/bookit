import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization; // Changed to non-nullable
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    required this.textCapitalization, // Made required
    this.validator,
    this.prefixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.white,
              )
            : null,
      ),
      validator: validator,
    );
  }
}
