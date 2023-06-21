import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/layouts/mobile_layout.dart';
import 'package:instaclone/layouts/responsive_layouts.dart';
import 'package:instaclone/layouts/web_layout.dart';
import 'package:instaclone/services/auth/firebase_auth_provider.dart';
import 'package:instaclone/utilites/bloc/auth_bloc.dart';
import 'package:instaclone/utilites/global/colors.dart';
import 'package:instaclone/utilites/global/routes.dart';
import 'package:instaclone/views/create_profile_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const MaterialColor primaryBlack = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int _blackPrimaryValue = 0xFF000000;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          FirebaseAuthProvider(),
        ),
        child: const MobileLayout(),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        createProfileRoute: (context) => const CreateProfileView(),
      },
    );
  }
}
