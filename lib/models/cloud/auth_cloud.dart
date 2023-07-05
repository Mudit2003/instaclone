import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/models/cloud/auth_cloud_constatnts.dart';

class AuthCloud {
  final String name;
  final String bio;
  final String userName;
  final List followers;
  final List followings;

  AuthCloud({
    required this.followers,
    required this.followings,
    required this.userName,
    required this.name,
    required this.bio,
  });

  AuthCloud.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : userName = snapshot.data()[userNameField] as String,
        bio = snapshot.data()[ownerBioField] as String,
        followers = snapshot.data()[followerField] as List,
        followings = snapshot.data()[followerField] as List,
        name = snapshot.data()[nameField] as String;
}
