import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/utilites/extensions/email_validator.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_bloc.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_event.dart';
import 'package:instaclone/utilites/global/colors.dart';
import 'package:instaclone/utilites/methods/debouncer.dart';
import 'package:instaclone/utilites/methods/on_pressed_add_event.dart';
import 'package:instaclone/widgets/buttons.dart';
import 'package:instaclone/widgets/email_field.dart';
import 'package:instaclone/widgets/password_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  late final TextEditingController _emailFieldController;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final Debouncer _emailDebouncer;
  bool validationStatus = false;

  void emailListener() {
    String text = _emailFieldController.text;
    log(text);
    _emailDebouncer.cancel();
    _emailDebouncer.call(
      () {
        if (!validationStatus && text.isValidEmail()) {
          setState(() {
            validationStatus = true;
          });
        }
        if (validationStatus && !text.isValidEmail()) {
          setState(() {
            validationStatus = false;
          });
        }
      },
    );
  }

  @override
  void initState() {
    _emailFieldController = TextEditingController();
    _confirmPassword = TextEditingController();
    _password = TextEditingController();
    _emailFieldController.addListener(emailListener);
    _emailDebouncer = Debouncer();
    super.initState();
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("state change");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed:
                  onPressed(context: context, event: const AuthEventLogOut()),
              icon: const Icon(Icons.arrow_back),
            ),
            const Spacer(
              flex: 4,
            ),
            const Spacer(
              flex: 5,
            ),
            const Text(
              "What's your Email?",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
            const Spacer(
              flex: 2,
            ),
            const Text(
              "Enter the email address at which you can be contacted. No one will see this on your profile.",
              softWrap: true,
              style: TextStyle(color: Colors.white60, fontSize: 15),
            ),
            GenericEmailField(emailFieldController: _emailFieldController),
            const Spacer(
              flex: 1,
            ),
            GenericPasswordField(
              controller: _password,
              labelText: 'Password',
              obscureText: obscureTextPassword,
              toggleFunction: () {
                setState(() {
                  obscureTextPassword = !obscureTextPassword;
                });
              },
            ),
            const Spacer(
              flex: 1,
            ),
            GenericPasswordField(
              controller: _confirmPassword,
              labelText: 'Confirm Password',
              obscureText: obscureTextConfirmPassword,
              toggleFunction: () {
                setState(() {
                  obscureTextConfirmPassword = !obscureTextConfirmPassword;
                });
              },
            ),
            const Spacer(flex: 1),
            const Spacer(flex: 1),
            ValidationButtons(
              buttonLabel: "Next",
              buttonLogic: validationStatus
                  ? () {
                      if (_confirmPassword.text == _password.text) {
                        context.read<AuthBloc>().add(AuthEventRegister(
                              email: _emailFieldController.text,
                              password: _password.text,
                            ));
                      } else {
                        log("Passwords do not match");
                      }
                    }
                  : null,
            ),
            const Spacer(
              flex: 1,
            ),
            const Spacer(
              flex: 20,
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              style: TextButton.styleFrom(
                alignment: Alignment.center,
                minimumSize: const Size.fromHeight(5),
              ),
              child: const Text(
                "Already have an account?",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
