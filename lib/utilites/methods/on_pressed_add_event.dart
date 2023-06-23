import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/utilites/bloc/auth_bloc.dart';
import 'package:instaclone/utilites/bloc/auth_event.dart';

void Function() onPressed({
  required AuthEvent event,
  required BuildContext context,
}) {
  devtools.log("Onpressed called");
  return () {
    context.read<AuthBloc>().add(event);
  };
}
