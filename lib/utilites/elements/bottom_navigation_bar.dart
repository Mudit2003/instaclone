import 'package:flutter/material.dart';

BottomNavigationBar instaBottomNaviagtionBar() {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'home',
        backgroundColor: Colors.black,
        activeIcon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.search_outlined,
        ),
        label: "search",
        backgroundColor: Colors.black,
        activeIcon: Icon(Icons.search),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.add_box_outlined,
        ),
        label: "Post",
        backgroundColor: Colors.black,
        activeIcon: Icon(Icons.add_box),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.movie_outlined,
        ),
        label: "reels",
        backgroundColor: Colors.black,
        activeIcon: Icon(Icons.movie),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person_outlined,
        ),
        label: "profile",
        backgroundColor: Colors.black,
        activeIcon: Icon(Icons.person),
      ),
    ],
    type: BottomNavigationBarType.shifting,
    selectedItemColor: Colors.white,
    backgroundColor: Colors.black,
  );
}
