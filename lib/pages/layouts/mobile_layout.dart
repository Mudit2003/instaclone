import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_bloc.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_event.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_state.dart';
import 'package:instaclone/pages/views/create_profile_view.dart';
import 'package:instaclone/pages/views/login_view.dart';
import 'package:instaclone/pages/views/register_view.dart';
import 'package:instaclone/pages/views/verification_view.dart';

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
          } else if (state is AuthStateLoggedIn) {
            return const Placeholder();
          } else if (state is AuthStateNeedsVerification) {
            return const VerificationView();
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
