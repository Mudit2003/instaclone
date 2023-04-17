import 'package:flutter/material.dart';

class GenericTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPass;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final FocusNode? focusNode;
  final bool? obscureText;
  final void Function(TapUpDetails)? onTapUp;
  final void Function(TapDownDetails)? onTapDown;
  const GenericTextFormField({
    required this.controller,
    required this.labelText,
    this.isPass = false,
    this.textInputType = TextInputType.text,
    super.key,
    this.validator,
    this.onChange,
    this.obscureText,
    this.focusNode,
    this.onTapUp,
    this.onTapDown,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        suffixIcon: isPass
            ? GestureDetector(
                onTapUp: onTapUp,
                onTapDown: onTapDown,
                child: const Icon(
                  Icons.visibility_rounded,
                ),
              )
            : null,
      ),
      autocorrect: false,
      enableSuggestions: false,
      autofocus: true,
      keyboardType: textInputType,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: validator,
    );
  }
}
