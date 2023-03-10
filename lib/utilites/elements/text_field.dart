import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPass;
  final TextInputType textInputType;
  const GenericTextField({
    required this.controller,
    required this.labelText,
    this.isPass = false,
    this.textInputType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
      autocorrect: false,
      enableSuggestions: false,
      autofocus: true,
      keyboardType: textInputType,
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
