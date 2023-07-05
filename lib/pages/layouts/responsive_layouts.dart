import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/pages/layouts/mobile_layout.dart';
import 'package:instaclone/pages/layouts/web_layout.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_bloc.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_event.dart';
import 'package:instaclone/utilites/global/dimensions.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileLayout;
  final Widget webLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.webLayout,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(
          const AuthEventInitialize(),
        );
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return const WebLayout();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
