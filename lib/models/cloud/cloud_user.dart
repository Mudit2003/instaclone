import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/models/cloud/auth_cloud_constatnts.dart';

class UserProfile {
  final String userName;
  final String name;
  final String bio;
  // final Uint8List image;
  final List<String> followers;
  final List<String> followings;

  UserProfile({
    required this.userName,
    required this.name,
    required this.bio,
    // required this.image,
    required this.followers,
    required this.followings,
  });

  UserProfile.fromSnapshot({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
  })  : userName = snapshot[userNameField] as String,
        name = snapshot[nameField] as String,
        bio = snapshot[ownerBioField] as String,
        followers = snapshot[followerField] as List<String>,
        followings = snapshot[followingField] as List<String>;
}
