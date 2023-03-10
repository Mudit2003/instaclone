import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaclone/utilites/bloc/auth_event.dart';
import 'package:instaclone/utilites/elements/text_field.dart';
import 'package:instaclone/utilites/global/colors.dart';
import 'package:instaclone/utilites/on_pressed_add_event.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("state change");
    return ValueListenableBuilder(
        valueListenable: _email,
        builder: (BuildContext context, TextEditingValue value, _) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: onPressed(
                        context: context, event: const AuthEventLogOut()),
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
                  const Spacer(
                    flex: 1,
                  ),
                  GenericTextField(
                    controller: _email,
                    labelText: 'Email address',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  GenericTextField(
                    isPass: true,
                    controller: _password,
                    labelText: 'Password',
                  ),
                  const Spacer(flex: 1),
                  ElevatedButton(
                    onPressed:
                        // log(_email.text);
                        // _email.text.isValidEmail()?
                        // this does not work as there is not state change observed as the widget rebuilds so we have to either use the onchange variable of the textfield and use it to change the state but that will kinda be like fighting the ui or we can use a value listenable builder // either way we are changing the whole scaffold we can use a textform field instead
                        EmailValidator.validate(_email.text)
                            ? onPressed(
                                event: AuthEventRegister(
                                  email: _email.text,
                                  password: _password.text,
                                ),
                                context: context,
                              )
                            : null,
                    // },
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: const Color.fromARGB(255, 12, 68, 199),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text("Next"),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   style: TextButton.styleFrom(
                  //     side: const BorderSide(
                  //       color: Colors.white,
                  //     ),
                  //     minimumSize: const Size.fromHeight(8),
                  //   ),
                  //   child: const Padding(
                  //     padding: EdgeInsets.all(12.0),
                  //     child: Text(
                  //       "Sign up with Mobile",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const Spacer(
                    flex: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      onPressed(
                        event: const AuthEventLogOut(),
                        context: context,
                      );
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
        });
  }
}
