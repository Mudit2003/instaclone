import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:instaclone/extensions/email_validator.dart';
import 'package:instaclone/utilites/bloc/auth_event.dart';
import 'package:instaclone/utilites/elements/text_form_field.dart';
import 'package:instaclone/utilites/global/colors.dart';
import 'package:instaclone/utilites/methods/debouncer.dart';
import 'package:instaclone/utilites/methods/on_pressed_add_event.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _obscureTextA = true;
  bool _obscureTextB = true;
  late final Debouncer _debouncer;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final FocusNode _passwordFieldFocusNode;
  late final FocusNode _confirmPasswordFieldFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _debouncer = Debouncer();
    _confirmPassword = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _passwordFieldFocusNode = FocusNode();
    _confirmPasswordFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _passwordFieldFocusNode.dispose();
    _confirmPasswordFieldFocusNode.dispose();
    super.dispose();
  }

  void setStateCall(void Function() onSetStateCall) {
    _debouncer.call(() {
      setState(onSetStateCall);
    });
  }

  void inContactA(TapDownDetails details) {
    setStateCall(() {
      _obscureTextA = false;
      if (_passwordFieldFocusNode.hasPrimaryFocus) return;
      _passwordFieldFocusNode.canRequestFocus = false;
    });
  }

  void outContactA(TapUpDetails details) {
    setStateCall(
      () {
        _obscureTextA = true;
        if (_passwordFieldFocusNode.hasPrimaryFocus) return;
        _passwordFieldFocusNode.canRequestFocus = false;
      },
    );
  }

  void inContactB(TapDownDetails details) {
    setStateCall(() {
      _obscureTextB = false;
      if (_confirmPasswordFieldFocusNode.hasPrimaryFocus) return;
      _confirmPasswordFieldFocusNode.canRequestFocus = false;
    });
  }

  void outContactB(TapUpDetails details) {
    setStateCall(
      () {
        _obscureTextB = true;
        if (_passwordFieldFocusNode.hasPrimaryFocus) return;
        _passwordFieldFocusNode.canRequestFocus = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log("state change");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              const Spacer(
                flex: 1,
              ),
              GenericTextFormField(
                controller: _email,
                labelText: 'Email address',
                onChange: (value) {
                  setStateCall(() {});
                },
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  log(value.toString());
                  if (value?.isValidEmail() ?? false) {
                    return null;
                  } else {
                    return 'enter a valid email';
                  }
                },
              ),
              const Spacer(
                flex: 1,
              ),
              GenericTextFormField(
                // focusNode: _passwordFieldFocusNode,
                onChange: (value) {
                  setState(() {});
                },
                isPass: true,
                obscureText: _obscureTextA,
                controller: _password,
                labelText: 'Password',
                onTapUp: outContactA,
                onTapDown: inContactA,
              ),
              const Spacer(flex: 1),
              GenericTextFormField(
                obscureText: _obscureTextB,
                focusNode: _confirmPasswordFieldFocusNode,
                isPass: true,
                controller: _confirmPassword,
                labelText: ' Confirm Password',
                onTapUp: outContactB,
                onTapDown: inContactB,
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed:
                    // log(_email.text);
                    // _email.text.isValidEmail()?
                    // this does not work as there is not state change observed as the widget rebuilds so we have to either use the onchange variable of the textfield and use it to change the state but that will kinda be like fighting the ui or we can use a value listenable builder // either way we are changing the whole scaffold we can use a textform field instead

                    _formKey.currentState?.validate() ?? false
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
                onPressed: _formKey.currentState?.validate() ?? false
                    ? onPressed(
                        event: const AuthEventLogOut(),
                        context: context,
                      )
                    : null,
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
      ),
    );
  }
}
