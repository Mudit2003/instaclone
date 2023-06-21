import 'package:flutter/material.dart';

class ValidationButtons extends StatelessWidget {
  final String buttonLabel;
  final void Function()? buttonLogic;
  const ValidationButtons({
    super.key,
    required this.buttonLabel,
    required this.buttonLogic,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonLogic,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: const Color.fromARGB(255, 12, 68, 199),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(buttonLabel),
    );
  }
}
