import 'package:flutter/material.dart';

class GenericPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FocusNode? focusNode;
  final bool obscureText;
  final void Function() toggleFunction;
  const GenericPasswordField({
    required this.controller,
    required this.labelText,
    super.key,
    required this.obscureText,
    this.focusNode,
    required this.toggleFunction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
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
        suffixIcon: IconButton(
          icon: obscureText
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off_outlined),
          onPressed: toggleFunction,
        ),
      ),
      autocorrect: false,
      enableSuggestions: false,
      autofocus: true,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
