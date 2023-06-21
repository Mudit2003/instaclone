import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      backgroundColor: const Color(0xFF1b2e3b),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(
              flex: 5,
            ),
            const Text(
              "What's your mobile number?",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
            const Spacer(
              flex: 2,
            ),
            const Text(
              'Enter the mobile number on which you can be contacted. No one wil see this on your profile.',
              softWrap: true,
              style: TextStyle(color: Colors.white60, fontSize: 15),
            ),
            const Spacer(
              flex: 1,
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                ),
                labelText: 'Mobile Number',
                labelStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(6),
                    right: Radius.circular(6),
                  ),
                ),
              ),
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
            const Spacer(flex: 1),
            const Text(
              "You may recieve SMS notifications from us for security and login purposes.",
              softWrap: true,
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: const Color.fromARGB(255, 12, 68, 199),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Next"),
            ),
            const Spacer(
              flex: 1,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                side: const BorderSide(
                  color: Colors.white,
                ),
                minimumSize: const Size.fromHeight(8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Sign up with email address",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                alignment: Alignment.center,
                minimumSize: const Size.fromHeight(5),
              ),
              child: const Text(
                "Already have an account?",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
