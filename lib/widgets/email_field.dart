
import 'package:flutter/material.dart';

class GenericEmailField extends StatelessWidget {
  final TextEditingController emailFieldController;
  const GenericEmailField({super.key, required this.emailFieldController});

  @override
  Widget build(BuildContext context) {
    return  TextField(
              controller: emailFieldController,
              decoration: const InputDecoration(
                label: Text("Email"),
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
              ),
            );
  }
}

