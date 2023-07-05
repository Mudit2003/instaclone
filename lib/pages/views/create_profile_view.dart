import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_bloc.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_event.dart';
import 'package:instaclone/utilites/global/colors.dart';
import 'package:instaclone/widgets/text_field.dart';
import '../../../widgets/buttons.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key});

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  late final TextEditingController _username;
  late final TextEditingController _name;
  late final TextEditingController _bio;

  @override
  void initState() {
    _username = TextEditingController();
    _name = TextEditingController();
    _bio = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 4,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      "https://www.tutorialspoint.com/basics_of_computer_science/images/computer_networking.jpg"),
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_a_photo_rounded,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),
            GenericTextField(
              // Profile picture icon button ,
              controller: _username,
              labelText: "Enter your username",
            ),
            const Spacer(
              flex: 1,
            ),
            GenericTextField(
              controller: _name,
              labelText: "How should people call you",
            ),
            const Spacer(
              flex: 10,
            ),
            GenericTextField(
              controller: _bio,
              labelText: "BIO",
            ),
            const Spacer(
              flex: 10,
            ),
            ValidationButtons(
              buttonLabel: "Next",
              buttonLogic: () {
                context.read<AuthBloc>().add(AuthEventCreateProfile(
                      bio: _bio.text,
                      following: const [],
                      followers: const [],
                      name: _name.text,
                      username: _username.text,
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
