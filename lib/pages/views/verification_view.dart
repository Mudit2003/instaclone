import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_bloc.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_event.dart';
import 'package:instaclone/utilites/global/colors.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(6, 50, 0, 2),
              child: const Text(
                "Please verify your email by clicking on the activation code sent to your email , if not recieved click here",
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 0, 2),
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventSendEmailVerification());
                  },
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(6, 1, 2, 1))),
                  child: const Text("Send Email Verification"),
                )),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
              child: const Text("Sign In with a different account"),
            )
          ],
        ));
  }
}
