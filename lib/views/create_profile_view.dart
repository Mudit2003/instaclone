
import 'package:flutter/material.dart';
import 'package:instaclone/utilites/elements/text_field.dart';
import 'package:instaclone/utilites/global/colors.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key});

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  late final TextEditingController _username;
  late final TextEditingController _name;

  @override
  void initState() {
    _username = TextEditingController();
    _name = TextEditingController();
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
          ],
        ),
      ),
    );
  }
}
