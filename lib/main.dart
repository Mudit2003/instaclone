import 'package:flutter/material.dart';
import 'package:instaclone/utilites/global/colors.dart';
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
      home: const CreateProfileView(),
      // home: BlocProvider<AuthBloc>(
      //   create: (context) => AuthBloc(
      //     FirebaseAuthProvider(),
      //   ),
      //   child: const ResponsiveLayout(
      //     mobileLayout: MobileLayout(),
      //     webLayout: WebLayout(),
      //   ),
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}