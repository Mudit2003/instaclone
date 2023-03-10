import 'package:flutter/material.dart';

class FeedAppBar extends AppBar {
  FeedAppBar({super.key})
      : super(
          title: const Text('Instagram'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.messenger_outline_rounded),
            )
          ],
        );
}

class FeedBody extends StatefulWidget {
  const FeedBody({super.key});

  @override
  State<FeedBody> createState() => _FeedBodyState();
}

class _FeedBodyState extends State<FeedBody> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
