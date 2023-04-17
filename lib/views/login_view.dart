import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaclone/utilites/bloc/auth_bloc.dart';
import 'package:instaclone/utilites/bloc/auth_event.dart';
import 'package:instaclone/utilites/bloc/auth_state.dart';
import 'package:instaclone/utilites/elements/text_field.dart';
import 'package:instaclone/utilites/global/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 18,
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  // ignore: deprecated_member_use
                  color: primaryColor,
                ),
                const Spacer(
                  flex: 12,
                ),
                GenericTextField(
                  controller: _email,
                  labelText: "Username, email address or mobile number",
                  textInputType: TextInputType.emailAddress,
                ),
                const Spacer(
                  flex: 1,
                ),
                GenericTextField(
                  controller: _password,
                  labelText: "Password",
                  isPass: true,
                ),
                const Spacer(
                  flex: 1,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: blueColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthEventLogin(
                            email: _email.text,
                            password: _password.text,
                          ),
                        );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(email: null),
                        );
                  },
                  child: const Text(
                    "Forgotten Password?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 18,
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventToRegister(),
                        );
                    // Navigator.of(context).pushNamed('/register/');
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                    shape: const ContinuousRectangleBorder(),
                  ),
                  child: const Text(
                    "Create New Account",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
