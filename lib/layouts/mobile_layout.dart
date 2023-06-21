import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/utilites/bloc/auth_bloc.dart';
import 'package:instaclone/utilites/bloc/auth_event.dart';
import 'package:instaclone/utilites/bloc/auth_state.dart';
import 'package:instaclone/views/create_profile_view.dart';
import 'package:instaclone/views/login_view.dart';
import 'package:instaclone/views/register_view.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(
          const AuthEventInitialize(),
        );
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          log(state.toString());
          if (state is AuthStateRegistering) {
            return const RegisterView();
          }
          if (state is AuthStateLoggedIn) {
            return Container();
          } else if (state is AuthStateNeedsVerification) {
            return const Placeholder();
          } else if (state is AuthStateLoggedOut) {
            return const LoginView();
          } else if (state is AuthStateForgotPassword) {
            return const Placeholder();
          } else if (state is AuthStateToCreateProfile) {
            return const CreateProfileView();
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
