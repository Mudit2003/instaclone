import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/utilites/bloc/auth_bloc.dart';
import 'package:instaclone/utilites/bloc/auth_event.dart';

Function() onPressed({
  required AuthEvent event,
  required BuildContext context,
}) {
  log("Onpressed called");
  return () {
    context.read<AuthBloc>().add(event);
  };
}
